## File Upload module

The File Upload module was written for the 2.1.x Form Tools Core to provide a mechanism to upload files through your forms In 2.0.x releases, this field type was part of the Core code, but it was moved to a separate module to accommodate the new field type structure. Why is this better?

Well, we can now develop multiple modules to handle different file handling. e.g. have a separate "image" field that could create thumbnails. Or, we could update this module - or create another - to allow for uploading multiple files at once. [An Image Manager module has been in the works for some time!]

Now the file upload functionality is self-contained in a module, it will make it easier for us to roll out changes.
Functionally, this module provides all the same options as 2.0.x releases, only with a slightly different interface. Read through the documentation in the link below for more information.

### Documentation

- [https://docs.formtools.org/modules/field_type_file/](https://docs.formtools.org/modules/field_type_file/)


### Other Links

- [Available Form Tools modules](https://modules.formtools.org/)
- [About Form Tools modules](https://docs.formtools.org/userdoc/modules/) 
- [Installation instructions](https://docs.formtools.org/userdoc/modules/installing/)
- [Upgrading](https://docs.formtools.org/userdoc/modules/upgrading/)
