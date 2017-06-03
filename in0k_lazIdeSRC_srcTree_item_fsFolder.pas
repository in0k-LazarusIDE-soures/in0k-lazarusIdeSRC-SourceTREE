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
   _SrchPaths_:sSrcTree_SrchPath;
  public
    property inSearchPATHs:sSrcTree_SrchPath read _SrchPaths_;
  end;

procedure SrcTree_fsFolder__addSearhPATH(const item:tSrcTree_fsFLDR; SearchPATH:eSrcTree_SrchPath);

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

procedure SrcTree_fsFolder__addSearhPATH(const item:tSrcTree_fsFLDR; SearchPATH:eSrcTree_SrchPath);
begin
    {$ifOpt D+}Assert(Assigned(item));{$endIf}
    item._SrchPaths_:=item._SrchPaths_+[SearchPATH];
end;

//------------------------------------------------------------------------------

function tSrcTree_fsFLDR._get_ItemHint_:string;
begin
    result:=inherited _get_ItemHint_;
    if _SrchPaths_<>[] then begin
        result:=result+LineEnding+'SrchPaths:'+_SrchPaths__2__text_(_SrchPaths_);
		end;
end;

end.

