unit in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_ITEM_4USEs;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  sysutils,
  PackageIntf,
  CodeToolManager,
  CodeCache,

  LazLoggerBase, LazIDEIntf,


  in0k_lazIdeSRC_srcTree_textFunction__usesSection,
  //in0k_lazIde_ Function__usesSection,

  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_item_fsFile,

  in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_CORE;

type

 tSrcTree_itmHandler4Build__f8a_Item_4USEs=class(tSrcTree_itmHandler__f8a_Item)
  protected
   // function
  protected
    function  _nameItemT0FileName_(const itemName:string):string;
    procedure _nameListT0FileList_(const nameList:tStrings);
  protected
    function _prc_4AllSection_(const CodeBuffer:TCodeBuffer; out MainSection,ImplSection:TStrings):boolean;
  protected
    function _prc_possible_(const item:tSrcTree_item):boolean; override;
    function _prc_4CodeBUF_(const CodeBuffer:TCodeBuffer; const Names:tStrings):boolean; override;
  end;

 tSrcTree_itmHandler4Build__f8a_Item_4USEs_InMainSection=class(tSrcTree_itmHandler4Build__f8a_Item_4USEs)
  protected
    function _prc_4CodeBUF_(const CodeBuffer:TCodeBuffer; const Names:tStrings):boolean; override;
  end;

 tSrcTree_itmHandler4Build__f8a_Item_4USEs_InImplSection=class(tSrcTree_itmHandler4Build__f8a_Item_4USEs)
  protected
    function _prc_4CodeBUF_(const CodeBuffer:TCodeBuffer; const Names:tStrings):boolean; override;
  end;

implementation



function tSrcTree_itmHandler4Build__f8a_Item_4USEs._nameItemT0FileName_(const itemName:string):string;
var untName:string;
begin
    if srcTree_txtFnk__unitName_hazInToken(itemName, untName) then begin
        // лазарус САМ ищет этот файл ... гм ..
        {todo: ВЕРНУТЬ ОБРАТНО}
        //result:= false ;//LazarusIDE.FindUnitFile(untName,TObject(self.LazOBJ),[]);
    end
    else result:=itemName;
end;

procedure tSrcTree_itmHandler4Build__f8a_Item_4USEs._nameListT0FileList_(const nameList:tStrings);
var i:integer;
begin
    writeLOG(inttostr(nameList.Count));
    for i:=0 to nameList.Count-1 do begin
        // тупо заменяем
        nameList.Strings[i]:=_nameItemT0FileName_(nameList.Strings[i]);
    end;
end;

//------------------------------------------------------------------------------

function tSrcTree_itmHandler4Build__f8a_Item_4USEs._prc_4AllSection_(const CodeBuffer:TCodeBuffer; out MainSection,ImplSection:TStrings):boolean;
begin
    // надо .. НАДО ... ОБЯЗАТЕЛЬНО НАДО ... !!!
    // инициализировать переменные перед использованием
    MainSection:=nil;
    ImplSection:=nil;
    result:=CodeToolBoss.FindUsedUnitFiles(CodeBuffer, MainSection,ImplSection)
end;

//------------------------------------------------------------------------------

function tSrcTree_itmHandler4Build__f8a_Item_4USEs._prc_possible_(const item:tSrcTree_item):boolean;
begin
    result:=(item is tSrcTree_fsFILE)and //< это файл, и он определенного типа
            (tSrcTree_fsFILE(item).fileKIND in [pftUnit,pftVirtualUnit,pftMainUnit,pftInclude]);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//{todo: как-то это поелегантнее, что ли, надо сделать}

function tSrcTree_itmHandler4Build__f8a_Item_4USEs._prc_4CodeBUF_(const CodeBuffer:TCodeBuffer; const Names:tStrings):boolean;
var MainSection,ImplSection:TStrings;
begin {todo: проверки в дебуг режиме???}
    result:=_prc_4AllSection_(CodeBuffer, MainSection,ImplSection);
    if result then begin //< копируем имена (пути)
        writeLOG('ssssssssssssssssssssssssssssssssssssssss');
        if Assigned(MainSection) then Names.AddStrings(MainSection);
        if Assigned(ImplSection) then Names.AddStrings(ImplSection);
    end;
    MainSection.FREE;
    ImplSection.FREE;
    //---
    writeLOG('Names.Count='+inttostr(Names.Count));
   _nameListT0FileList_(Names);
end;

function tSrcTree_itmHandler4Build__f8a_Item_4USEs_InMainSection._prc_4CodeBUF_(const CodeBuffer:TCodeBuffer; const Names:tStrings):boolean;
var MainSection,ImplSection:TStrings;
begin {todo: проверки в дебуг режиме???}
    result:=_prc_4AllSection_(CodeBuffer, MainSection,ImplSection);
    if result then begin //< копируем имена (пути)
        if Assigned(MainSection) then Names.AddStrings(MainSection);
        //if Assigned(ImplSection) then Names.AddStrings(ImplSection);
    end;
    MainSection.FREE;
    ImplSection.FREE;
    //---
   _nameListT0FileList_(Names);
end;

function tSrcTree_itmHandler4Build__f8a_Item_4USEs_InImplSection._prc_4CodeBUF_(const CodeBuffer:TCodeBuffer; const Names:tStrings):boolean;
var MainSection,ImplSection:TStrings;
begin {todo: проверки в дебуг режиме???}
    result:=_prc_4AllSection_(CodeBuffer, MainSection,ImplSection);
    if result then begin //< копируем имена (пути)
        //if Assigned(MainSection) then Names.AddStrings(MainSection);
        if Assigned(ImplSection) then Names.AddStrings(ImplSection);
    end;
    MainSection.FREE;
    ImplSection.FREE;
    //---
   _nameListT0FileList_(Names);
end;

end.

