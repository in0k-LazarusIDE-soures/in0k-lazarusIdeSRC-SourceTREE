unit in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_ITEM_4USEs;

{$mode objfpc}{$H+}

interface

uses
  Classes,

  PackageIntf,
  CodeToolManager,
  CodeCache,

  in0k_lazIdeSRC_srcTree_CORE_item,
  in0k_lazIdeSRC_srcTree_item_fsFile,

  in0k_lazIdeSRC_srcTree_itmHandler4Build__f8a_CORE;

type

 tSrcTree_itmHandler4Build__f8a_Item_4USEs=class(tSrcTree_itmHandler4Build__f8a_Item)
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

function tSrcTree_itmHandler4Build__f8a_Item_4USEs._prc_4AllSection_(const CodeBuffer:TCodeBuffer; out MainSection,ImplSection:TStrings):boolean;
begin
    // надо .. НАДО ... ОБЯЗАТЕЛЬНО НАДО ... !!!
    // инициализировать переменные перед использованием
    MainSection:=nil;
    ImplSection:=nil;
    result:=CodeToolBoss.FindUsedUnitFiles(CodeBuffer, MainSection,ImplSection)
    //result:=CodeToolBoss.FindUsedUnitNames(CodeBuffer, MainSection,ImplSection)
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
        if Assigned(MainSection) then Names.AddStrings(MainSection);
        if Assigned(ImplSection) then Names.AddStrings(ImplSection);
    end;
    MainSection.FREE;
    ImplSection.FREE;
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
end;

end.

