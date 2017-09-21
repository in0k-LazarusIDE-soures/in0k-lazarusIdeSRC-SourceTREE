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
    function _prc_possible_(const item:tSrcTree_item):boolean; override;
    function _prc_4CodeBUF_(const CodeBuffer:TCodeBuffer; const Names:tStrings):boolean; override;
  end;

implementation

function tSrcTree_itmHandler4Build__f8a_Item_4USEs._prc_possible_(const item:tSrcTree_item):boolean;
begin
    result:=(item is tSrcTree_fsFILE)and //< это файл, и он определенного типа
            (tSrcTree_fsFILE(item).fileKIND in [pftUnit,pftVirtualUnit,pftMainUnit,pftInclude]);
end;

function tSrcTree_itmHandler4Build__f8a_Item_4USEs._prc_4CodeBUF_(const CodeBuffer:TCodeBuffer; const Names:tStrings):boolean;
var MainUsesSection,ImplementationUsesSection:TStrings;
begin
    try
        if CodeToolBoss.FindUsedUnitFiles(CodeBuffer, MainUsesSection,ImplementationUsesSection) then begin
            Names.AddStrings(MainUsesSection);
            Names.AddStrings(ImplementationUsesSection);
        end;

    except
      writeLOG('ERRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR');
    end;
    MainUsesSection          .FREE;
    ImplementationUsesSection.FREE;
end;

end.

