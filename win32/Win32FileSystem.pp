unit Win32FileSystem;

{$mode delphi}

interface

  function ExtractFileNameWithoutExt(FilePath: UnicodeString): UnicodeString;

implementation

  uses SysUtils, StrUtils;

  function ExtractFileNameWithoutExt;
  begin
    if ExtractFileExt(FilePath) <> '' then
      Result := ExtractFilename(Copy(FilePath, 1, RPos(ExtractFileExt(FilePath), FilePath) - 1))
    else
      Result := ExtractFilename(FilePath);
  end;


end.