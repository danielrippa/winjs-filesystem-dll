# WinjsFileSystem.dll

```

  get-js-value: ->

    folder-separator: string
    drive-separator: string
    path-separator: string

    text-file:

      read: (filename: string) -> string
      write: (filename: string) -> boolean
      append-line: (filename: string, line: string) -> boolean

    file-path:

      get-filename: (filename: string) -> string
      get-basename: (filename: string) -> string
      get-path: (filename: string) -> string
      get-folder-path: (filename: string) -> string
      get-file-extension: (filename: string) -> string
      get-relativepath: (folder1: string, folder2: string) -> string

    file-exists: (file-path: string) -> boolean
    folder-exists: (folder-path: string) -> boolean

    get-current-folder: -> string
    set-current-folder: (folder: string) -> boolean

```
