                        </div>
                    </div>

                </td>
            </tr>
            </table>

            </div>

            <div class="clear"></div>

        </div>
    </div>
</div>

<div id="footer">
    <span style="float:right"><img src="{$theme_url}/images/footer_right.jpg" width="16" height="37" /></span>
    <span style="float:left"><img src="{$theme_url}/images/footer_left.jpg" width="13" height="37" /></span>
    <div style="padding-top:3px;">{$footer_text|default:""}</div>
    {if $g_enable_benchmarking}
        {show_page_load_time}
    {/if}
</div>

</body>
</html>
