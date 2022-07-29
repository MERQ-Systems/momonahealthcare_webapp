
;(function ($, window) {
  'use strict';

  var CONSTANTS = {
    CONTINUOUS_SCROLLING_TIMEOUT_INTERVAL: 50, // timeout interval for repeatedly moving the tabs container
                                                // by one increment while the mouse is held down--decrease to
                                                // make mousedown continous scrolling faster
    SCROLL_ARROW_WIDTH: 20,
    SCROLL_OFFSET_FRACTION: 6, // each click moves the container this fraction of the fixed container--decrease
                               // to make the tabs scroll farther per click

    DATA_KEY_DDMENU_MODIFIED: 'scrtabsddmenumodified',
    DATA_KEY_IS_MOUSEDOWN: 'scrtabsismousedown',

    CSS_CLASSES: {
      SCROLL_ARROW_DISABLE: 'scrtabs-disable'
    },

    EVENTS: {
      CLICK: 'click.scrtabs',
      DROPDOWN_MENU_HIDE: 'hide.bs.dropdown.scrtabs',
      DROPDOWN_MENU_SHOW: 'show.bs.dropdown.scrtabs',
      FORCE_REFRESH: 'forcerefresh.scrtabs',
      WINDOW_RESIZE: 'resize.scrtabs',
      TABS_READY: 'ready.scrtabs'
    }
  };


  // smartresize from Paul Irish (debounced window resize)
  (function (sr) {
    var debounce = function (func, threshold, execAsap) {
      var timeout;

      return function debounced() {
        var obj = this, args = arguments;
        function delayed() {
          if (!execAsap) {
            func.apply(obj, args);
          }
          timeout = null;
        }

        if (timeout) {
          clearTimeout(timeout);
        } else if (execAsap) {
          func.apply(obj, args);
        }

        timeout = setTimeout(delayed, threshold || 100);
      };
    };
    $.fn[sr] = function (fn) { return fn ? this.bind(CONSTANTS.EVENTS.WINDOW_RESIZE, debounce(fn)) : this.trigger(sr); };

  })('smartresize');



  /* ***********************************************************************************
   * ElementsHandler - Class that each instance of ScrollingTabsControl will instantiate
   * **********************************************************************************/
  function ElementsHandler(scrollingTabsControl) {
    var ehd = this;

    ehd.stc = scrollingTabsControl;
  }

  // ElementsHandler prototype methods
  (function (p) {
      p.initElements = function (options) {
        var ehd = this;

        ehd.setElementReferences();
        ehd.stc.$scrollArrows.hide();

        ehd.setEventListeners();
      };

      p.refreshAllElementSizes = function () {
        var ehd = this,
            stc = ehd.stc,
            smv = stc.scrollMovement,
            scrollArrowsWereVisible = stc.scrollArrowsVisible,
            actionsTaken = {
              didScrollToActiveTab: false
            },
            isPerformingSlideAnim = false,
            minPos;

        ehd.setElementWidths();
        ehd.setScrollArrowVisibility();

        // this could have been a window resize or the removal of a
        // dynamic tab, so make sure the movable container is positioned
        // correctly because, if it is far to the left and we increased the
        // window width, it's possible that the tabs will be too far left,
        // beyond the min pos.
        if (stc.scrollArrowsVisible) {
          // make sure container not too far left
          minPos = smv.getMinPos();

          isPerformingSlideAnim = smv.scrollToActiveTab({
            isOnWindowResize: true
          });

          if (!isPerformingSlideAnim) {
            smv.refreshScrollArrowsDisabledState();

            if (stc.movableContainerLeftPos < minPos) {
              smv.incrementScrollRight(minPos);
            }
          }

          actionsTaken.didScrollToActiveTab = true;

        } else if (scrollArrowsWereVisible) {
          // scroll arrows went away after resize, so position movable container at 0
          stc.movableContainerLeftPos = 0;
          smv.slideMovableContainerToLeftPos();
        }

        return actionsTaken;
      };

      p.setElementReferences = function () {
        var ehd = this,
            stc = ehd.stc,
            $tabsContainer = stc.$tabsContainer;

        stc.isNavPills = false;

        stc.$fixedContainer = $tabsContainer.find('.scrtabs-tabs-fixed-container');
        stc.$movableContainer = $tabsContainer.find('.scrtabs-tabs-movable-container');
        stc.$tabsUl = $tabsContainer.find('.nav-tabs');

        // check for pills
        if (!stc.$tabsUl.length) {
          stc.$tabsUl = $tabsContainer.find('.nav-pills');

          if (stc.$tabsUl.length) {
            stc.isNavPills = true;
          }
        }

        stc.$tabsLiCollection = stc.$tabsUl.find('> li');
        stc.$leftScrollArrow = $tabsContainer.find('.scrtabs-js-tab-scroll-arrow-left');
        stc.$rightScrollArrow = $tabsContainer.find('.scrtabs-js-tab-scroll-arrow-right');
        stc.$scrollArrows = stc.$leftScrollArrow.add(stc.$rightScrollArrow);

        stc.$win = $(window);
      };

      p.setElementWidths = function () {
        var ehd = this,
            stc = ehd.stc;

        stc.containerWidth = stc.$tabsContainer.outerWidth();
        stc.winWidth = stc.$win.width();

        stc.scrollArrowsCombinedWidth = stc.$leftScrollArrow.outerWidth() + stc.$rightScrollArrow.outerWidth();

        ehd.setFixedContainerWidth();
        ehd.setMovableContainerWidth();
      };

      p.setEventListeners = function () {
        var ehd = this,
            stc = ehd.stc,
            evh = stc.eventHandlers; // eventHandlers

        stc.$leftScrollArrow.off('.scrtabs').on({
          'mousedown.scrtabs': function (e) { evh.handleMousedownOnLeftScrollArrow.call(evh, e); },
          'mouseup.scrtabs': function (e) { evh.handleMouseupOnLeftScrollArrow.call(evh, e); },
          'click.scrtabs': function (e) { evh.handleClickOnLeftScrollArrow.call(evh, e); }
        });

        stc.$rightScrollArrow.off('.scrtabs').on({
          'mousedown.scrtabs': function (e) { evh.handleMousedownOnRightScrollArrow.call(evh, e); },
          'mouseup.scrtabs': function (e) { evh.handleMouseupOnRightScrollArrow.call(evh, e); },
          'click.scrtabs': function (e) { evh.handleClickOnRightScrollArrow.call(evh, e); }
        });

        stc.$win.smartresize(function (e) { evh.handleWindowResize.call(evh, e); });

        $('body').on(CONSTANTS.EVENTS.FORCE_REFRESH, stc.elementsHandler.refreshAllElementSizes.bind(stc.elementsHandler));
      };

      p.setFixedContainerWidth = function () {
        var ehd = this,
            stc = ehd.stc;

        stc.$fixedContainer.width(stc.fixedContainerWidth = stc.$tabsContainer.outerWidth());
      };

      p.setFixedContainerWidthForHiddenScrollArrows = function () {
        var ehd = this,
            stc = ehd.stc;

        stc.$fixedContainer.width(stc.fixedContainerWidth);
      };

      p.setFixedContainerWidthForVisibleScrollArrows = function () {
        var ehd = this,
            stc = ehd.stc;

        stc.$fixedContainer.width(stc.fixedContainerWidth - stc.scrollArrowsCombinedWidth);
      };

      p.setMovableContainerWidth = function () {
        var ehd = this,
            stc = ehd.stc,
            $tabLi = stc.$tabsUl.find('> li');

        stc.movableContainerWidth = 0;

        if ($tabLi.length) {

          $tabLi.each(function __getLiWidth() {
            var $li = $(this),
                totalMargin = 0;

            if (stc.isNavPills) { // pills have a margin-left, tabs have no margin
              totalMargin = parseInt($li.css('margin-left'), 10) + parseInt($li.css('margin-right'), 10);
            }

            stc.movableContainerWidth += ($li.outerWidth() + totalMargin);
          });

          stc.movableContainerWidth += 1;

          // if the tabs don't span the width of the page, force the
          // movable container width to full page width so the bottom
          // border spans the page width instead of just spanning the
          // width of the tabs
          if (stc.movableContainerWidth < stc.fixedContainerWidth) {
            stc.movableContainerWidth = stc.fixedContainerWidth;
          }
        }

        stc.$movableContainer.width(stc.movableContainerWidth);
      };

      p.setScrollArrowVisibility = function () {
        var ehd = this,
            stc = ehd.stc,
            shouldBeVisible = stc.movableContainerWidth > stc.fixedContainerWidth;

        if (shouldBeVisible && !stc.scrollArrowsVisible) {
          stc.$scrollArrows.show();
          stc.scrollArrowsVisible = true;
        } else if (!shouldBeVisible && stc.scrollArrowsVisible) {
          stc.$scrollArrows.hide();
          stc.scrollArrowsVisible = false;
        }

        if (stc.scrollArrowsVisible) {
          ehd.setFixedContainerWidthForVisibleScrollArrows();
        } else {
          ehd.setFixedContainerWidthForHiddenScrollArrows();
        }
      };

  }(ElementsHandler.prototype));


  function EventHandlers(scrollingTabsControl) {
    var evh = this;

    evh.stc = scrollingTabsControl;
  }

  // prototype methods
  (function (p){
    p.handleClickOnLeftScrollArrow = function (e) {
      var evh = this,
          stc = evh.stc;

      stc.scrollMovement.incrementScrollLeft();
    };

    p.handleClickOnRightScrollArrow = function (e) {
      var evh = this,
          stc = evh.stc,
          scrollMovement = stc.scrollMovement;

      scrollMovement.incrementScrollRight(scrollMovement.getMinPos());
    };

    p.handleMousedownOnLeftScrollArrow = function (e) {
      var evh = this,
          stc = evh.stc;

      stc.scrollMovement.startScrollLeft();
    };

    p.handleMousedownOnRightScrollArrow = function (e) {
      var evh = this,
          stc = evh.stc;

      stc.scrollMovement.startScrollRight();
    };

    p.handleMouseupOnLeftScrollArrow = function (e) {
      var evh = this,
          stc = evh.stc;

      stc.scrollMovement.stopScrollLeft();
    };

    p.handleMouseupOnRightScrollArrow = function (e) {
      var evh = this,
          stc = evh.stc;

      stc.scrollMovement.stopScrollRight();
    };

    p.handleWindowResize = function (e) {
      var evh = this,
          stc = evh.stc,
          newWinWidth = stc.$win.width();

      if (newWinWidth === stc.winWidth) {
        return false;
      }

      stc.winWidth = newWinWidth;
      stc.elementsHandler.refreshAllElementSizes();
    };

  }(EventHandlers.prototype));



  function ScrollMovement(scrollingTabsControl) {
    var smv = this;

    smv.stc = scrollingTabsControl;
  }

  // prototype methods
  (function (p) {

    p.continueScrollLeft = function () {
      var smv = this,
          stc = smv.stc;

      setTimeout(function() {
        if (stc.$leftScrollArrow.data(CONSTANTS.DATA_KEY_IS_MOUSEDOWN) && (stc.movableContainerLeftPos < 0)) {
          if (!smv.incrementScrollLeft()) { // scroll limit not reached, so keep scrolling
            smv.continueScrollLeft();
          }
        }
      }, CONSTANTS.CONTINUOUS_SCROLLING_TIMEOUT_INTERVAL);
    };

    p.continueScrollRight = function (minPos) {
      var smv = this,
          stc = smv.stc;

      setTimeout(function() {
        if (stc.$rightScrollArrow.data(CONSTANTS.DATA_KEY_IS_MOUSEDOWN) && (stc.movableContainerLeftPos > minPos)) {
          // slide tabs LEFT -> decrease movable container's left position
          // min value is (movableContainerWidth - $tabHeader width)
          if (!smv.incrementScrollRight(minPos)) {
            smv.continueScrollRight(minPos);
          }
        }
      }, CONSTANTS.CONTINUOUS_SCROLLING_TIMEOUT_INTERVAL);
    };

    p.decrementMovableContainerLeftPos = function (minPos) {
      var smv = this,
          stc = smv.stc;

      stc.movableContainerLeftPos -= (stc.fixedContainerWidth / CONSTANTS.SCROLL_OFFSET_FRACTION);
      if (stc.movableContainerLeftPos < minPos) {
        stc.movableContainerLeftPos = minPos;
      } else if (stc.scrollToTabEdge) {
        smv.setMovableContainerLeftPosToTabEdge('right');

        if (stc.movableContainerLeftPos < minPos) {
          stc.movableContainerLeftPos = minPos;
        }
      }
    };

    p.disableLeftScrollArrow = function () {
      var smv = this,
          stc = smv.stc;

      if (!stc.disableScrollArrowsOnFullyScrolled || !stc.scrollArrowsVisible) {
        return;
      }

      stc.$leftScrollArrow.addClass(CONSTANTS.CSS_CLASSES.SCROLL_ARROW_DISABLE);
    };

    p.disableRightScrollArrow = function () {
      var smv = this,
          stc = smv.stc;

      if (!stc.disableScrollArrowsOnFullyScrolled || !stc.scrollArrowsVisible) {
        return;
      }

      stc.$rightScrollArrow.addClass(CONSTANTS.CSS_CLASSES.SCROLL_ARROW_DISABLE);
    };

    p.enableLeftScrollArrow = function () {
      var smv = this,
          stc = smv.stc;

      if (!stc.disableScrollArrowsOnFullyScrolled || !stc.scrollArrowsVisible) {
        return;
      }

      stc.$leftScrollArrow.removeClass(CONSTANTS.CSS_CLASSES.SCROLL_ARROW_DISABLE);
    };

    p.enableRightScrollArrow = function () {
      var smv = this,
          stc = smv.stc;

      if (!stc.disableScrollArrowsOnFullyScrolled || !stc.scrollArrowsVisible) {
        return;
      }

      stc.$rightScrollArrow.removeClass(CONSTANTS.CSS_CLASSES.SCROLL_ARROW_DISABLE);
    };

    p.getMinPos = function () {
      var smv = this,
          stc = smv.stc;

      return stc.scrollArrowsVisible ? (stc.fixedContainerWidth - stc.movableContainerWidth - stc.scrollArrowsCombinedWidth) : 0;
    };

    p.getMovableContainerCssLeftVal = function () {
      var smv = this,
          stc = smv.stc;

      return (stc.movableContainerLeftPos === 0) ? '0' : stc.movableContainerLeftPos + 'px';
    };

    p.incrementScrollLeft = function () {
      var smv = this,
          stc = smv.stc;

      stc.movableContainerLeftPos += (stc.fixedContainerWidth / CONSTANTS.SCROLL_OFFSET_FRACTION);

      if (stc.movableContainerLeftPos > 0) {
        stc.movableContainerLeftPos = 0;
      } else if (stc.scrollToTabEdge) {
        smv.setMovableContainerLeftPosToTabEdge('left');
      }

      smv.slideMovableContainerToLeftPos();
      smv.enableRightScrollArrow();

      return (stc.movableContainerLeftPos === 0); // indicates scroll limit reached
    };

    p.incrementScrollRight = function (minPos) {
      var smv = this,
          stc = smv.stc;

      smv.decrementMovableContainerLeftPos(minPos);
      smv.slideMovableContainerToLeftPos();

      if (stc.movableContainerLeftPos !== 0) {
        smv.enableLeftScrollArrow();
      }

      return (stc.movableContainerLeftPos === minPos);
    };

    p.refreshScrollArrowsDisabledState = function() {
      var smv = this,
          stc = smv.stc;

      if (!stc.disableScrollArrowsOnFullyScrolled || !stc.scrollArrowsVisible) {
        return;
      }

      if (!stc.movableContainerLeftPos) {
        smv.disableLeftScrollArrow();
        smv.enableRightScrollArrow();
      } else {
        smv.enableLeftScrollArrow();

        if (stc.movableContainerLeftPos <= smv.getMinPos()) {
          smv.disableRightScrollArrow();
        } else {
          smv.enableRightScrollArrow();
        }
      }
    };

    p.scrollToActiveTab = function (options) {
      var smv = this,
          stc = smv.stc,
          RIGHT_OFFSET_BUFFER = 20,
          $activeTab,
          activeTabLeftPos,
          activeTabRightPos,
          rightArrowLeftPos;

      if (!stc.scrollArrowsVisible) {
        return;
      }

      $activeTab = stc.$tabsUl.find('li.active');

      if (!$activeTab.length) {
        return;
      }

      activeTabLeftPos = $activeTab.offset().left;
      activeTabRightPos = activeTabLeftPos + $activeTab.outerWidth();

      rightArrowLeftPos = stc.fixedContainerWidth - RIGHT_OFFSET_BUFFER;

      if (activeTabRightPos > rightArrowLeftPos) { // active tab off right side
        stc.movableContainerLeftPos -= (activeTabRightPos - rightArrowLeftPos + CONSTANTS.SCROLL_ARROW_WIDTH);
        smv.slideMovableContainerToLeftPos();
        return true;
      } else if (activeTabLeftPos < CONSTANTS.SCROLL_ARROW_WIDTH) { // active tab off left side
        stc.movableContainerLeftPos += CONSTANTS.SCROLL_ARROW_WIDTH - activeTabLeftPos;
        smv.slideMovableContainerToLeftPos();
        return true;
      }

      return false;
    };

    p.setMovableContainerLeftPosToTabEdge = function (scrollArrowClicked) {
      var smv = this,
          stc = smv.stc,
          offscreenWidth = -stc.movableContainerLeftPos,
          totalTabWidth = 0;

        // make sure LeftPos is set so that a tab edge will be against the
        // left scroll arrow so we won't have a partial, cut-off tab
        stc.$tabsLiCollection.each(function (index) {
          var tabWidth = $(this).width();

          totalTabWidth += tabWidth;

          if (totalTabWidth > offscreenWidth) {
            stc.movableContainerLeftPos = (scrollArrowClicked === 'left') ? -(totalTabWidth - tabWidth) : -totalTabWidth;
            return false; // exit .each() loop
          }

        });
    };

    p.slideMovableContainerToLeftPos = function () {
      var smv = this,
          stc = smv.stc,
          leftVal;

      if (stc.movableContainerLeftPos > 0) {
        stc.movableContainerLeftPos = 0;
      } else if (stc.movableContainerLeftPos < smv.getMinPos()) {
        stc.movableContainerLeftPos = smv.getMinPos();
      }

      stc.movableContainerLeftPos = stc.movableContainerLeftPos / 1;
      leftVal = smv.getMovableContainerCssLeftVal();

      smv.performingSlideAnim = true;

      stc.$movableContainer.stop().animate({ left: leftVal }, 'slow', function __slideAnimComplete() {
        var newMinPos = smv.getMinPos();

        smv.performingSlideAnim = false;

        // if we slid past the min pos--which can happen if you resize the window
        // quickly--move back into position
        if (stc.movableContainerLeftPos < newMinPos) {
          smv.decrementMovableContainerLeftPos(newMinPos);
          stc.$movableContainer.stop().animate({ left: smv.getMovableContainerCssLeftVal() }, 'fast', function() {
            smv.refreshScrollArrowsDisabledState();
          });
        } else {
          smv.refreshScrollArrowsDisabledState();
        }
      });
    };

    p.startScrollLeft = function () {
      var smv = this,
          stc = smv.stc;

      stc.$leftScrollArrow.data(CONSTANTS.DATA_KEY_IS_MOUSEDOWN, true);
      smv.continueScrollLeft();
    };

    p.startScrollRight = function () {
      var smv = this,
          stc = smv.stc;

      stc.$rightScrollArrow.data(CONSTANTS.DATA_KEY_IS_MOUSEDOWN, true);
      smv.continueScrollRight(smv.getMinPos());
    };

    p.stopScrollLeft = function () {
      var smv = this,
          stc = smv.stc;

      stc.$leftScrollArrow.data(CONSTANTS.DATA_KEY_IS_MOUSEDOWN, false);
    };

    p.stopScrollRight = function () {
      var smv = this,
          stc = smv.stc;

      stc.$rightScrollArrow.data(CONSTANTS.DATA_KEY_IS_MOUSEDOWN, false);
    };

  }(ScrollMovement.prototype));



  function ScrollingTabsControl($tabsContainer) {
    var stc = this;

    stc.$tabsContainer = $tabsContainer;

    stc.movableContainerLeftPos = 0;
    stc.scrollArrowsVisible = false;
    stc.scrollToTabEdge = false;
    stc.disableScrollArrowsOnFullyScrolled = false;

    stc.scrollMovement = new ScrollMovement(stc);
    stc.eventHandlers = new EventHandlers(stc);
    stc.elementsHandler = new ElementsHandler(stc);
  }

  // prototype methods
  (function (p) {
    p.initTabs = function (options, $scroller, readyCallback, attachTabContentToDomCallback) {
      var stc = this,
          elementsHandler = stc.elementsHandler;

      if (options.scrollToTabEdge) {
        stc.scrollToTabEdge = true;
      }

      if (options.disableScrollArrowsOnFullyScrolled) {
        stc.disableScrollArrowsOnFullyScrolled = true;
      }

      setTimeout(initTabsAfterTimeout, 100);

      function initTabsAfterTimeout() {
        var actionsTaken;

        // if we're just wrapping non-data-driven tabs, the user might
        // have the .nav-tabs hidden to prevent the clunky flash of
        // multi-line tabs on page refresh, so we need to make sure
        // they're visible before trying to wrap them
        $scroller.find('.nav-tabs').show();

        elementsHandler.initElements(options);
        actionsTaken = elementsHandler.refreshAllElementSizes();

        $scroller.css('visibility', 'visible');

        if (attachTabContentToDomCallback) {
          attachTabContentToDomCallback();
        }

        if (readyCallback) {
          readyCallback();
        }
      }
    };

    p.scrollToActiveTab = function(options) {
      var stc = this,
          smv = stc.scrollMovement;

      smv.scrollToActiveTab(options);
    };
  }(ScrollingTabsControl.prototype));




  ////////////////////////////////////////////
  //
  // plugin-specific stuff
  //
  ////////////////////////////////////////////
  var tabElements = (function () {

    return {
      getElTabPaneForLi: getElTabPaneForLi,
      getNewElNavTabs: getNewElNavTabs,
      getNewElScrollerElementWrappingNavTabsInstance: getNewElScrollerElementWrappingNavTabsInstance,
      getNewElTabAnchor: getNewElTabAnchor,
      getNewElTabContent: getNewElTabContent,
      getNewElTabLi: getNewElTabLi,
      getNewElTabPane: getNewElTabPane
    };

    ///////////////////

    // ---- retrieve existing elements from the DOM ----------
    function getElTabPaneForLi($li) {
      return $($li.find('a').attr('href'));
    }


    // ---- create new elements ----------
    function getNewElNavTabs() {
      return $('<ul class="nav nav-tabs" role="tablist"></ul>');
    }

    function getNewElScrollerElementWrappingNavTabsInstance($navTabsInstance) {
      var $tabsContainer = $('<div class="scrtabs-tab-container"></div>'),
          $leftArrow = $('<div class="scrtabs-tab-scroll-arrow scrtabs-js-tab-scroll-arrow-left"><span class="fa fa-chevron-left"></span></div>'),
          $rightArrow = $('<div class="scrtabs-tab-scroll-arrow scrtabs-js-tab-scroll-arrow-right"><span class="fa fa-chevron-right"></span></div>'),
          $fixedContainer = $('<div class="scrtabs-tabs-fixed-container"></div>'),
          $movableContainer = $('<div class="scrtabs-tabs-movable-container"></div>');

      return $tabsContainer
                .append($leftArrow,
                        $fixedContainer.append($movableContainer.append($navTabsInstance)),
                        $rightArrow);
    }

    function getNewElTabAnchor(tab, propNames) {
      return $('<a role="tab" data-toggle="tab"></a>')
              .attr('href', '#' + tab[propNames.paneId])
              .html(tab[propNames.title]);
    }

    function getNewElTabContent() {
      return $('<div class="tab-content"></div>');
    }

    function getNewElTabLi(tab, propNames, forceActiveTab) {
      var $li = $('<li role="presentation" class=""></li>'),
          $a = getNewElTabAnchor(tab, propNames).appendTo($li);

      if (tab[propNames.disabled]) {
        $li.addClass('disabled');
        $a.attr('data-toggle', '');
      } else if (forceActiveTab && tab[propNames.active]) {
        $li.addClass('active');
      }

      return $li;
    }

    function getNewElTabPane(tab, propNames, forceActiveTab) {
      var $pane = $('<div role="tabpanel" class="tab-pane"></div>')
                  .attr('id', tab[propNames.paneId])
                  .html(tab[propNames.content]);

      if (forceActiveTab && tab[propNames.active]) {
        $pane.addClass('active');
      }

      return $pane;
    }


  }()); // tabElements

  var tabUtils = (function () {

    return {
      didTabOrderChange: didTabOrderChange,
      getIndexOfClosestEnabledTab: getIndexOfClosestEnabledTab,
      getTabIndexByPaneId: getTabIndexByPaneId,
      storeDataOnLiEl: storeDataOnLiEl
    };

    ///////////////////

    function didTabOrderChange($currTabLis, updatedTabs, propNames) {
      var isTabOrderChanged = false;

      $currTabLis.each(function (currDomIdx) {
        var newIdx = getTabIndexByPaneId(updatedTabs, propNames.paneId, $(this).data('tab')[propNames.paneId]);

        if ((newIdx > -1) && (newIdx !== currDomIdx)) { // tab moved
          isTabOrderChanged = true;
          return false; // exit .each() loop
        }
      });

      return isTabOrderChanged;
    }

    function getIndexOfClosestEnabledTab($currTabLis, startIndex) {
      var lastIndex = $currTabLis.length - 1,
          closestIdx = -1,
          incrementFromStartIndex = 0,
          testIdx = 0;

      // expand out from the current tab looking for an enabled tab;
      // we prefer the tab after us over the tab before
      while ((closestIdx === -1) && (testIdx >= 0)) {

        if ( (((testIdx = startIndex + (++incrementFromStartIndex)) <= lastIndex) &&
              !$currTabLis.eq(testIdx).hasClass('disabled')) ||
              (((testIdx = startIndex - incrementFromStartIndex) >= 0) &&
               !$currTabLis.eq(testIdx).hasClass('disabled')) ) {

          closestIdx = testIdx;

        }
      }

      return closestIdx;
    }

    function getTabIndexByPaneId(tabs, paneIdPropName, paneId) {
      var idx = -1;

      tabs.some(function (tab, i) {
        if (tab[paneIdPropName] === paneId) {
          idx = i;
          return true; // exit loop
        }
      });

      return idx;
    }

    function storeDataOnLiEl($li, tabs, index) {
      $li.data({
        tab: $.extend({}, tabs[index]), // store a clone so we can check for changes
        index: index
      });
    }

  }()); // tabUtils


  function buildNavTabsAndTabContentForTargetElementInstance($targetElInstance, settings, readyCallback) {
    var tabs = settings.tabs,
        propNames = {
          paneId: settings.propPaneId,
          title: settings.propTitle,
          active: settings.propActive,
          disabled: settings.propDisabled,
          content: settings.propContent
        },
        ignoreTabPanes = settings.ignoreTabPanes,
        hasTabContent = tabs.length && tabs[0][propNames.content] !== undefined,
        $navTabs = tabElements.getNewElNavTabs(),
        $tabContent = tabElements.getNewElTabContent(),
        $scroller,
        attachTabContentToDomCallback = ignoreTabPanes ? null : function() {
          $scroller.after($tabContent);
        };

    if (!tabs.length) {
      return;
    }

    tabs.forEach(function(tab, index) {
      tabElements
        .getNewElTabLi(tab, propNames, true) // true -> forceActiveTab
        .appendTo($navTabs);

      // build the tab panes if we weren't told to ignore them and there's
      // tab content data available
      if (!ignoreTabPanes && hasTabContent) {
        tabElements
          .getNewElTabPane(tab, propNames, true) // true -> forceActiveTab
          .appendTo($tabContent);
      }
    });

    $scroller = wrapNavTabsInstanceInScroller($navTabs,
                                              settings,
                                              readyCallback,
                                              attachTabContentToDomCallback);

    $scroller.appendTo($targetElInstance);

    $targetElInstance.data({
      scrtabs: {
        tabs: tabs,
        propNames: propNames,
        ignoreTabPanes: ignoreTabPanes,
        hasTabContent: hasTabContent,
        scroller: $scroller
      }
    });

    // once the nav-tabs are wrapped in the scroller, attach each tab's
    // data to it for reference later; we need to wait till they're
    // wrapped in the scroller because we wrap a *clone* of the nav-tabs
    // we built above, not the original nav-tabs
    $scroller.find('.nav-tabs > li').each(function (index) {
      tabUtils.storeDataOnLiEl($(this), tabs, index);
    });
  }

  function checkForTabAdded(refreshData) {
    var updatedTabsArray = refreshData.updatedTabsArray,
        propNames = refreshData.propNames,
        ignoreTabPanes = refreshData.ignoreTabPanes,
        options = refreshData.options,
        $currTabLis = refreshData.$currTabLis,
        $navTabs = refreshData.$navTabs,
        $currTabContentPanesContainer = ignoreTabPanes ? null : refreshData.$currTabContentPanesContainer,
        $currTabContentPanes = ignoreTabPanes ? null : refreshData.$currTabContentPanes,
        isInitTabsRequired = false;

    // make sure each tab in the updated tabs array has a corresponding DOM element
    updatedTabsArray.forEach(function (tab, idx) {
      var $li = $currTabLis.find('a[href="#' + tab[propNames.paneId] + '"]'),
          isTabIdxPastCurrTabs = (idx >= $currTabLis.length),
          $pane;

      if (!$li.length) { // new tab
        isInitTabsRequired = true;

        // add the tab, add its pane (if necessary), and refresh the scroller
        $li = tabElements.getNewElTabLi(tab, propNames, options.forceActiveTab);
        tabUtils.storeDataOnLiEl($li, updatedTabsArray, idx);

        if (isTabIdxPastCurrTabs) { // append to end of current tabs
          $li.appendTo($navTabs);
        } else {                        // insert in middle of current tabs
          $li.insertBefore($currTabLis.eq(idx));
        }

        if (!ignoreTabPanes && tab[propNames.content] !== undefined) {
          $pane = tabElements.getNewElTabPane(tab, propNames, options.forceActiveTab);
          if (isTabIdxPastCurrTabs) { // append to end of current tabs
            $pane.appendTo($currTabContentPanesContainer);
          } else {                        // insert in middle of current tabs
            $pane.insertBefore($currTabContentPanes.eq(idx));
          }
        }

      }

    });

    return isInitTabsRequired;
  }

  function checkForTabPropertiesUpdated(refreshData) {
    var tabLiData = refreshData.tabLi,
        ignoreTabPanes = refreshData.ignoreTabPanes,
        $li = tabLiData.$li,
        $contentPane = tabLiData.$contentPane,
        origTabData = tabLiData.origTabData,
        newTabData = tabLiData.newTabData,
        propNames = refreshData.propNames,
        isInitTabsRequired = false;

    // update tab title if necessary
    if (origTabData[propNames.title] !== newTabData[propNames.title]) {
      $li.find('a[role="tab"]')
          .html(origTabData[propNames.title] = newTabData[propNames.title]);

      isInitTabsRequired = true;
    }

    // update tab active state if necessary
    if (refreshData.options.forceActiveTab) {
      // set the active tab based on the tabs array regardless of the current
      // DOM state, which could have been changed by the user clicking a tab
      // without those changes being reflected back to the tab data
      $li[newTabData[propNames.active] ? 'addClass' : 'removeClass']('active');

      $contentPane[newTabData[propNames.active] ? 'addClass' : 'removeClass']('active');

      origTabData[propNames.active] = newTabData[propNames.active];

      isInitTabsRequired = true;
    }

    // update tab content pane if necessary
    if (!ignoreTabPanes && origTabData[propNames.content] !== newTabData[propNames.content]) {
      $contentPane.html(origTabData[propNames.content] = newTabData[propNames.content]);
      isInitTabsRequired = true;
    }

    return isInitTabsRequired;
  }

  function checkForTabRemoved(refreshData) {
    var tabLiData = refreshData.tabLi,
        ignoreTabPanes = refreshData.ignoreTabPanes,
        $li = tabLiData.$li,
        idxToMakeActive;

    if (tabLiData.newIdx !== -1) { // tab was not removed--it has a valid index
      return false;
    }

    // if this was the active tab, make the closest enabled tab active
    if ($li.hasClass('active')) {

      idxToMakeActive = tabUtils.getIndexOfClosestEnabledTab(refreshData.$currTabLis, tabLiData.currDomIdx);
      if (idxToMakeActive > -1) {
        refreshData.$currTabLis
          .eq(idxToMakeActive)
          .addClass('active');

        if (!ignoreTabPanes) {
          refreshData.$currTabContentPanes
            .eq(idxToMakeActive)
            .addClass('active');
        }
      }
    }

    $li.remove();

    if (!ignoreTabPanes) {
      tabLiData.$contentPane.remove();
    }

    return true;
  }

  function checkForTabsOrderChanged(refreshData) {
    var $currTabLis = refreshData.$currTabLis,
        updatedTabsArray = refreshData.updatedTabsArray,
        propNames = refreshData.propNames,
        ignoreTabPanes = refreshData.ignoreTabPanes,
        newTabsCollection = [],
        newTabPanesCollection = ignoreTabPanes ? null : [];

    if (!tabUtils.didTabOrderChange($currTabLis, updatedTabsArray, propNames)) {
      return false;
    }

    // the tab order changed...
    updatedTabsArray.forEach(function (t, i) {
      var paneId = t[propNames.paneId];

      newTabsCollection.push(
          $currTabLis
            .find('a[role="tab"][href="#' + paneId + '"]')
            .parent('li')
          );

      if (!ignoreTabPanes) {
        newTabPanesCollection.push($('#' + paneId));
      }
    });

    refreshData.$navTabs.append(newTabsCollection);

    if (!ignoreTabPanes) {
      refreshData.$currTabContentPanesContainer.append(newTabPanesCollection);
    }

    return true;
  }

  function checkForTabsRemovedOrUpdated(refreshData) {
    var $currTabLis = refreshData.$currTabLis,
        updatedTabsArray = refreshData.updatedTabsArray,
        propNames = refreshData.propNames,
        isInitTabsRequired = false;


    $currTabLis.each(function (currDomIdx) {
      var $li = $(this),
          origTabData = $li.data('tab'),
          newIdx = tabUtils.getTabIndexByPaneId(updatedTabsArray, propNames.paneId, origTabData[propNames.paneId]),
          newTabData = (newIdx > -1) ? updatedTabsArray[newIdx] : null;

      refreshData.tabLi = {
        $li: $li,
        currDomIdx: currDomIdx,
        newIdx: newIdx,
        $contentPane: tabElements.getElTabPaneForLi($li),
        origTabData: origTabData,
        newTabData: newTabData
      };

      if (checkForTabRemoved(refreshData)) {
        isInitTabsRequired = true;
        return; // continue to next $li in .each() since we removed this tab
      }

      if (checkForTabPropertiesUpdated(refreshData)) {
        isInitTabsRequired = true;
      }
    });

    return isInitTabsRequired;
  }

  function destroyPlugin() {
    var $targetElInstance = $(this),
        scrtabsData = $targetElInstance.data('scrtabs'),
        $tabsContainer;

    if (!scrtabsData) {
      return;
    }

    scrtabsData.scroller
      .off(CONSTANTS.EVENTS.DROPDOWN_MENU_SHOW)
      .off(CONSTANTS.EVENTS.DROPDOWN_MENU_HIDE);

    // if there were any dropdown menus opened, remove the css we added to
    // them so they would display correctly
    scrtabsData.scroller
      .find('[data-' + CONSTANTS.DATA_KEY_DDMENU_MODIFIED + ']')
      .css({
        display: '',
        left: '',
        top: ''
      })
      .off(CONSTANTS.EVENTS.CLICK)
      .removeAttr('data-' + CONSTANTS.DATA_KEY_DDMENU_MODIFIED);

    if (scrtabsData.isWrapperOnly) { // we just wrapped nav-tabs markup, so restore it
      // $targetElInstance is the ul.nav-tabs
      $tabsContainer = $targetElInstance.parents('.scrtabs-tab-container');

      if ($tabsContainer.length) {
        $tabsContainer.replaceWith($targetElInstance);
      }

    } else { // we generated the tabs from data so destroy everything we created
      if (scrtabsData.scroller && scrtabsData.scroller.initTabs) {
        scrtabsData.scroller.initTabs = null;
      }

      // $targetElInstance is the container for the ul.nav-tabs we generated
      $targetElInstance
        .find('.scrtabs-tab-container')
        .add('.tab-content')
        .remove();
    }

    $targetElInstance.removeData('scrtabs');

    $(window).off(CONSTANTS.EVENTS.WINDOW_RESIZE);
    $('body').off(CONSTANTS.EVENTS.FORCE_REFRESH);
  }

  function listenForDropdownMenuTabs($scroller) {
    var $ddMenu;

    // for dropdown menus to show, we need to move them out of the
    // scroller and append them to the body
    $scroller
      .on(CONSTANTS.EVENTS.DROPDOWN_MENU_SHOW, handleDropdownShow)
      .on(CONSTANTS.EVENTS.DROPDOWN_MENU_HIDE, handleDropdownHide);

    function handleDropdownHide(e) {
      // move the dropdown menu back into its tab
      $(e.target).append($ddMenu.off(CONSTANTS.EVENTS.CLICK));
    }

    function handleDropdownShow(e) {
      var $ddParentTabLi = $(e.target),
          ddLiOffset = $ddParentTabLi.offset(),
          $currActiveTab = $scroller.find('li[role="presentation"].active'),
          ddMenuRightX,
          tabsContainerMaxX,
          ddMenuTargetLeft;

      $ddMenu = $ddParentTabLi
                  .find('.dropdown-menu')
                  .attr('data-' + CONSTANTS.DATA_KEY_DDMENU_MODIFIED, true);

      // if the dropdown's parent tab li isn't already active,
      // we need to deactivate any active menu item in the dropdown
      if ($currActiveTab[0] !== $ddParentTabLi[0]) {
        $ddMenu.find('li.active').removeClass('active');
      }

      // we need to do our own click handling because the built-in
      // bootstrap handlers won't work since we moved the dropdown
      // menu outside the tabs container
      $ddMenu.on(CONSTANTS.EVENTS.CLICK, 'a[role="tab"]', handleClickOnDropdownMenuItem);

      $('body').append($ddMenu);

      // make sure the menu doesn't go off the right side of the page
      ddMenuRightX = $ddMenu.width() + ddLiOffset.left;
      tabsContainerMaxX = $scroller.width() - (CONSTANTS.SCROLL_ARROW_WIDTH + 1);
      ddMenuTargetLeft = ddLiOffset.left;

      if (ddMenuRightX > tabsContainerMaxX) {
        ddMenuTargetLeft -= (ddMenuRightX - tabsContainerMaxX);
      }

      $ddMenu.css({
        'display': 'block',
        'top': ddLiOffset.top + $ddParentTabLi.outerHeight() - 2,
        'left': ddMenuTargetLeft
      });

      function handleClickOnDropdownMenuItem(e) {
        var $selectedMenuItemAnc = $(this),
            $selectedMenuItemLi = $selectedMenuItemAnc.parent('li'),
            $selectedMenuItemDropdownMenu = $selectedMenuItemLi.parent('.dropdown-menu'),
            targetPaneId = $selectedMenuItemAnc.attr('href');

        if ($selectedMenuItemLi.hasClass('active')) {
          return;
        }

        // once we select a menu item from the dropdown, deactivate
        // the current tab (unless it's our parent tab), deactivate
        // any active dropdown menu item, make our parent tab active
        // (if it's not already), and activate the selected menu item
        $scroller
          .find('li.active')
          .not($ddParentTabLi)
          .add($selectedMenuItemDropdownMenu.find('li.active'))
          .removeClass('active');

        $ddParentTabLi
          .add($selectedMenuItemLi)
          .addClass('active');

        // manually deactivate current active pane and activate our pane
        $('.tab-content .tab-pane.active').removeClass('active');
        $(targetPaneId).addClass('active');
      }

    }
  }

  function refreshDataDrivenTabs($container, options) {
    var instanceData = $container.data().scrtabs,
        scroller = instanceData.scroller,
        $navTabs = $container.find('.scrtabs-tab-container .nav-tabs'),
        $currTabContentPanesContainer = $container.find('.tab-content'),
        isInitTabsRequired = false,
        refreshData = {
          options: options,
          updatedTabsArray: instanceData.tabs,
          propNames: instanceData.propNames,
          ignoreTabPanes: instanceData.ignoreTabPanes,
          $navTabs: $navTabs,
          $currTabLis: $navTabs.find('> li'),
          $currTabContentPanesContainer: $currTabContentPanesContainer,
          $currTabContentPanes: $currTabContentPanesContainer.find('.tab-pane')
        };

    // to preserve the tab positions if we're just adding or removing
    // a tab, don't completely rebuild the tab structure, but check
    // for differences between the new tabs array and the old
    if (checkForTabAdded(refreshData)) {
      isInitTabsRequired = true;
    }

    if (checkForTabsOrderChanged(refreshData)) {
      isInitTabsRequired = true;
    }

    if (checkForTabsRemovedOrUpdated(refreshData)) {
      isInitTabsRequired = true;
    }

    if (isInitTabsRequired) {
      scroller.initTabs();
    }

    return isInitTabsRequired;
  }

  function refreshTargetElementInstance($container, options) {
    if (!$container.data('scrtabs')) { // target element doesn't have plugin on it
      return;
    }

    // force a refresh if the tabs are static html or they're data-driven
    // but the data didn't change so we didn't call initTabs()
    if ($container.data('scrtabs').isWrapperOnly || !refreshDataDrivenTabs($container, options)) {
      $('body').trigger(CONSTANTS.EVENTS.FORCE_REFRESH);
    }
  }

  function scrollToActiveTab() {
    var $targetElInstance = $(this),
        scrtabsData = $targetElInstance.data('scrtabs');

    if (!scrtabsData) {
      return;
    }

    scrtabsData.scroller.scrollToActiveTab();
  }

  function wrapNavTabsInstanceInScroller($navTabsInstance, settings, readyCallback, attachTabContentToDomCallback) {
    var $scroller = tabElements.getNewElScrollerElementWrappingNavTabsInstance($navTabsInstance.clone(true)), // use clone because we replaceWith later
        scrollingTabsControl = new ScrollingTabsControl($scroller),
        navTabsInstanceData = $navTabsInstance.data('scrtabs');

    if (!navTabsInstanceData) {
      $navTabsInstance.data('scrtabs', {
        scroller: $scroller
      });
    } else {
      navTabsInstanceData.scroller = $scroller;
    }

    $navTabsInstance.replaceWith($scroller.css('visibility', 'hidden'));

    $scroller.initTabs = function () {
      scrollingTabsControl.initTabs(settings,
                                    $scroller,
                                    readyCallback,
                                    attachTabContentToDomCallback);
    };

    $scroller.scrollToActiveTab = function() {
      scrollingTabsControl.scrollToActiveTab(settings);
    };

    $scroller.initTabs();

    listenForDropdownMenuTabs($scroller);

    return $scroller;
  }



  ////////////////////////

  var methods = {
    destroy: function() {
      var $targetEls = this;

      return $targetEls.each(destroyPlugin);
    },

    init: function(options) {
      var $targetEls = this,
          targetElsLastIndex = $targetEls.length - 1,
          settings = $.extend({}, $.fn.scrollingTabs.defaults, options || {});

      // ---- tabs NOT data-driven -------------------------
      if (!settings.tabs) {

        // just wrap the selected .nav-tabs element(s) in the scroller
        return $targetEls.each(function(index) {
          var dataObj = {
                isWrapperOnly: true
              },
              $targetEl = $(this).data({ scrtabs: dataObj }),
              readyCallback = (index < targetElsLastIndex) ? null : function() {
                $targetEls.trigger(CONSTANTS.EVENTS.TABS_READY);
              };

          wrapNavTabsInstanceInScroller($targetEl, settings, readyCallback);
        });

      }

      // ---- tabs data-driven -------------------------
      return $targetEls.each(function (index) {
        var $targetEl = $(this),
            readyCallback = (index < targetElsLastIndex) ? null : function() {
              $targetEls.trigger(CONSTANTS.EVENTS.TABS_READY);
            };

        buildNavTabsAndTabContentForTargetElementInstance($targetEl, settings, readyCallback);
      });
    },

    refresh: function(options) {
      var $targetEls = this,
          settings = $.extend({}, $.fn.scrollingTabs.defaults, options || {});

      return $targetEls.each(function () {
        refreshTargetElementInstance($(this), settings);
      });
    },

    scrollToActiveTab: function() {
      return this.each(scrollToActiveTab);
    }
  };


  $.fn.scrollingTabs = function(methodOrOptions) {

    if (methods[methodOrOptions]) {
      return methods[methodOrOptions].apply(this, Array.prototype.slice.call(arguments, 1));
    } else if (!methodOrOptions || (typeof methodOrOptions === 'object')) {
      return methods.init.apply(this, arguments);
    } else {
      $.error('Method ' + methodOrOptions + ' does not exist on $.scrollingTabs.');
    }
  };

  $.fn.scrollingTabs.defaults = {
    tabs: null,
    propPaneId: 'paneId',
    propTitle: 'title',
    propActive: 'active',
    propDisabled: 'disabled',
    propContent: 'content',
    ignoreTabPanes: false,
    scrollToTabEdge: false,
    disableScrollArrowsOnFullyScrolled: false,
    forceActiveTab: false
  };
}(jQuery, window));