unit ChakraFileSystem;

{$mode delphi}

interface

  uses
    ChakraTypes;

  function GetJsValue: TJsValue;

implementation

  uses
    Chakra, ChakraUtils, SysUtils, ChakraTextFile, ChakraFilePath;

  function ChakraFileExists(Args: PJsValue; ArgCount: Word): TJsValue;
  var
    FilePath: WideString;
  begin
    CheckParams('fileExists', Args, ArgCount, [jsString], 1);
    FilePath := JsstringAsString(Args^);

    Result := BooleanAsJsBoolean(FileExists(FilePath));
  end;

  function ChakraGetCurrentFolder(Args: PJsValue; ArgCount: Word): TJsValue;
  begin
    Result := StringAsJsString(GetCurrentDir);
  end;

  function ChakraSetCurrentFolder(Args: PJsValue; ArgCount: Word): TJsValue;
  var
    NewLocation: WideString;
  begin
    CheckParams('setCurrentFolder', Args, ArgCount, [jsString], 1);
    NewLocation := JsStringAsString(Args^);

    Result := BooleanAsJsBoolean(SetCurrentDir(NewLocation));
  end;

  function GetJsValue;
  begin
    Result := CreateObject;

    SetProperty(Result, 'folderSeparator', StringAsJsString(DirectorySeparator));
    SetProperty(Result, 'driveSeparator', StringAsJsString(DriveSeparator));
    SetProperty(Result, 'pathSeparator', StringAsJsString(PathSeparator));

    SetProperty(Result, 'textFile', GetChakraTextFile);
    SetProperty(Result, 'filePath', GetChakraFilePath);

    SetFunction(Result, 'fileExists', ChakraFileExists);
    SetFunction(Result, 'getCurrentFolder', ChakraGetCurrentFolder);
    SetFunction(Result, 'setCurrentFolder', ChakraSetCurrentFolder);
  end;

end.