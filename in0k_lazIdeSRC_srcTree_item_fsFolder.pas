unit in0k_lazIdeSRC_srcTree_item_fsFolder;

{$mode objfpc}{$H+}

interface

uses
  in0k_lazIdeSRC_srcTree_CORE_itemFileSystem;

type

  eSrcTree_SrchPath=(SrcTree_SrchPath__Fu,SrcTree_SrchPath__Fi,SrcTree_SrchPath__Fl);
  sSrcTree_SrchPath=set of eSrcTree_SrchPath;

type

 tSrcTree_fsFLDR=class(_tSrcTree_item_fsNodeFLDR_)
  protected
    function _get_ItemHint_:string; override;
  protected
   _SrchPths_:sSrcTree_SrchPath;
  public
    property inSearchPATHs:sSrcTree_SrchPath read _SrchPths_;
  public
    constructor Create(const Text:string; const KIND:sSrcTree_SrchPath);
    constructor Create(const Text:string); override;
  end;

procedure SrcTree_fsFolder__addSearchPATH(const item:tSrcTree_fsFLDR; const value:eSrcTree_SrchPath);
procedure SrcTree_fsFolder__set_SrchPATHs(const item:tSrcTree_fsFLDR; const value:sSrcTree_SrchPath);

function  SrcTree_fsFolder__SrchPTHs2TEXT(const item:tSrcTree_fsFLDR):string;


implementation

{%region --- inline functions ------------------------------------- /fold}

function _SrchPath__2__text_(const SrchPath:eSrcTree_SrchPath):string; {$ifOpt D-}inline;{$endIf}
begin
    case SrchPath of
        SrcTree_SrchPath__Fu: result:='Fu';
        SrcTree_SrchPath__Fi: result:='Fi';
        SrcTree_SrchPath__Fl: result:='Fl';
    end;
end;

const _cTxt_SrchPath_DELIMETER_=',';

function _SrchPaths__2__text_(const SrchPaths:sSrcTree_SrchPath):string; {$ifOpt D-}inline;{$endIf}
var tmp:eSrcTree_SrchPath;
begin
    result:='';
    for tmp:=low(eSrcTree_SrchPath) to high(eSrcTree_SrchPath) do begin
        if tmp in SrchPaths then begin
            if result<>'' then result:=result+_cTxt_SrchPath_DELIMETER_;
            result:=result+_SrchPath__2__text_(tmp);
        end;
    end;
end;

{%endregion}

constructor tSrcTree_fsFLDR.Create(const Text:string; const KIND:sSrcTree_SrchPath);
begin
    inherited Create(Text);
   _SrchPths_:=KIND;
end;

constructor tSrcTree_fsFLDR.Create(const Text:string);
begin
    Create(Text,[]);
end;

//------------------------------------------------------------------------------

function tSrcTree_fsFLDR._get_ItemHint_:string;
begin
    result:=inherited _get_ItemHint_;
    if _SrchPths_<>[] then begin
        result:=result+LineEnding+'SrchPaths:'+_SrchPaths__2__text_(_SrchPths_);
		end;
end;

//==============================================================================

procedure SrcTree_fsFolder__addSearchPATH(const item:tSrcTree_fsFLDR; const value:eSrcTree_SrchPath);
begin
    {$ifOpt D+}Assert(Assigned(item));{$endIf}
    item._SrchPths_:=item._SrchPths_+[value];
end;

procedure SrcTree_fsFolder__set_SrchPATHs(const item:tSrcTree_fsFLDR; const value:sSrcTree_SrchPath);
begin
    {$ifOpt D+}Assert(Assigned(item));{$endIf}
    item._SrchPths_:=value;
end;

//------------------------------------------------------------------------------

function SrcTree_fsFolder__SrchPTHs2TEXT(const item:tSrcTree_fsFLDR):string;
begin
    result:=_SrchPaths__2__text_(item.inSearchPATHs);
end;

end.

