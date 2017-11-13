unit in0k_lazIdeSRC_srcTree_CORE_itemFileSystem;

{$mode objfpc}{$H+}

interface

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.

uses {$ifDef in0k_lazIdeSRC_srcTree___DEBUG}in0k_lazIdeSRC_DEBUG,{$endIf}
     in0k_lazIdeSRC_srcTree_CORE_item,
     in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK;

type

  // элемент ФАЛОВОЙ системы (файлы, папки)
 _tStcTree_item_fsNode_=class(tSrcTree_item)
   protected
    function _get_ItemName_:string; override;
    function _get_ItemHint_:string; override;
   protected
    function _fsName_get_:string; virtual;
    function _fsPath_get_:string; virtual;
   public
    property  fsName:string read _fsName_get_;
    property  fsPath:string read _fsPath_get_;
   public
    constructor Create(const Text:string); override;
   end;

 _tSrcTree_item_fsNodeFILE_=class(_tStcTree_item_fsNode_)
   end;

 _tSrcTree_item_fsNodeFLDR_=class(_tStcTree_item_fsNode_)
   protected
    function _parentFLDR_beforeRoot_PRESENT_:boolean; {$ifOpt D-}inline;{$endIf}
   protected
    function _fsPath_get_:string; override;
   end;

 _tSrcTree_item_fsBaseDIR_=class(_tSrcTree_item_fsNodeFLDR_)
   protected
    function _get_ItemName_:string; override;
    function _fsPath_get_  :string; override;
   end;


implementation
{%region --- возня с ДЕБАГОМ -------------------------------------- /fold}
{$if declared(in0k_lazIde_DEBUG)}
    // `in0k_lazIde_DEBUG` - это функция ИНДИКАТОР что используется
    //                       моя "система имен и папок"
    {$define _debug_}     //< типа да ... можно делать ДЕБАГ отметки
{$else}
    {$undef _debug_}
{$endIf}
{%endregion}

constructor _tStcTree_item_fsNode_.Create(const Text:string);
begin // навеное srcTree_fsFnk_ChompPathDelim это ЗЛО .. но что делать?
    inherited Create(srcTree_fsFnk_ChompPathDelim(Text));
end;

//------------------------------------------------------------------------------

function _tStcTree_item_fsNode_._fsName_get_:string;
begin
    result:=srcTree_fsFnk_ExtractFileName(_item_Text_);
end;

function _tStcTree_item_fsNode_._fsPath_get_:string;
var tmp:tSrcTree_item;
begin
    result:='';
    //--- ищем родителя типа _tSrcTree_item_fsNodeFLDR_
    tmp:=ItemPRNT;
    while Assigned(tmp) do begin
        if tmp is _tSrcTree_item_fsNodeFLDR_ then begin
            result:=_tSrcTree_item_fsNodeFLDR_(tmp).fsPath; //< путь РОДИТелЯ
            result:= srcTree_fsFnk_ConcatPaths(result, _fsName_get_);
            //---
            BREAK;
        end;
        tmp:=tmp.ItemPRNT;
    end;
end;

//------------------------------------------------------------------------------

function _tStcTree_item_fsNode_._get_ItemName_:string;
begin
    result:=_fsName_get_;
end;

function _tStcTree_item_fsNode_._get_ItemHint_:string;
begin
    result:=_fsPath_get_;
end;


//------------------------------------------------------------------------------

(*function _tStcTree_item_fsNode_.__src_getDirName__:string;
begin
    result:=srcTree_fsFnk_ChompPathDelim(_src_getDirName_);
end;

function _tStcTree_item_fsNode_.__src_getDirName_abs_:string;
begin
    result:=srcTree_fsFnk_ChompPathDelim(_src_getDirName_abs_);
end;

function _tStcTree_item_fsNode_.__src_getObjName__:string;
begin
    result:=srcTree_fsFnk_ChompPathDelim(_src_getObjName_)
end;

function _tStcTree_item_fsNode_.__src_getPath__:string;
begin
    if (__src_getDirName__<>'') and (__src_getObjName__<>'')
    then result:=DirectorySeparator
    else result:='';
    result:=__src_getDirName__+result+__src_getObjName__;
end;

function _tStcTree_item_fsNode_.__src_getPath_abs_:string;
begin
    if (__src_getDirName_abs_<>'') and (__src_getObjName__<>'')
    then result:=DirectorySeparator
    else result:='';
    result:=__src_getDirName_abs_+result+__src_getObjName__;
end;

function _tStcTree_item_fsNode_.__src_isABSOLUTE__:boolean;
begin
    result:=srcTree_fsFnk_pathIsAbsolute(__src_getPath__);
end;  *)

//------------------------------------------------------------------------------

(*function _tStcTree_item_fsNode_._src_getDirName_:string;
var tmp:tSrcTree_item;
begin
    result:='';
    //--- ищем родителя типа _tStcTree_item_fsNode_
    tmp:=ItemPRNT;
    while Assigned(tmp) and not(tmp is _tStcTree_item_fsNode_) do tmp:=tmp.ItemPRNT;
    //---
    if Assigned(tmp) then begin // ага ... есть таки у кого спросить
        if ItemPRNT is _tSrcTree_item_fsBaseDIR_ then result:=''
        else begin
            // тока в случае с fsNodeDIR берем его ПОЛНЫЙ путь
            if ItemPRNT is _tSrcTree_item_fsNodeFLDR_
            then result:=_tSrcTree_item_fsNodeFLDR_(ItemPRNT).src_PATH
            else result:=_tStcTree_item_fsNode_   (ItemPRNT).src_DirName;
        end;
    end;
end;

function _tStcTree_item_fsNode_._src_getDirName_abs_:string;
var tmp:tSrcTree_item;
begin
    result:='';
    //--- ищем родителя типа _tStcTree_item_fsNode_
    tmp:=ItemPRNT;
    while Assigned(tmp) AND not(tmp is _tStcTree_item_fsNode_) do tmp:=tmp.ItemPRNT;
    //---
    if Assigned(tmp) then begin // ага ... есть таки у кого спросить
        if ItemPRNT is _tSrcTree_item_fsBaseDIR_ then result:=_tSrcTree_item_fsBaseDIR_(ItemPRNT).src_abs_PATH
        else begin
            // тока в случае с fsNodeDIR берем его ПОЛНЫЙ путь
            if ItemPRNT is _tSrcTree_item_fsNodeFLDR_
            then result:=_tSrcTree_item_fsNodeFLDR_(ItemPRNT).src_abs_PATH
            else result:=_tStcTree_item_fsNode_    (ItemPRNT).src_abs_DirName;
        end;
    end;
end;

function _tStcTree_item_fsNode_._src_getObjName_:string;
begin
    result:='';
end;*)

//------------------------------------------------------------------------------

(*function _tStcTree_item_fsNode_._get_ItemHint_:string;
begin
    result:=_fsPath_get_;
end;*)

//==============================================================================

function _tSrcTree_item_fsNodeFLDR_._parentFLDR_beforeRoot_PRESENT_:boolean;
var tmp:tSrcTree_item;
begin
    tmp:=ItemPRNT;
    result:=false;
    while Assigned(tmp) do begin
        result:=tmp is _tSrcTree_item_fsNodeFLDR_;
        if result or (tmp is _tSrcTree_ROOT_) then BREAK;
        //-->
        tmp:=tmp.ItemPRNT;
    end;
end;

function _tSrcTree_item_fsNodeFLDR_._fsPath_get_:string;
begin
    if (not Assigned(self.ItemPRNT)) or           //
       (self.ItemPRNT is _tSrcTree_ROOT_) or      //
       (not self._parentFLDR_beforeRoot_PRESENT_) // меджу мной и корнем НЕТ "папок"
    then result:=_item_Text_
    else result:= inherited;
end;

(*function _tSrcTree_item_fsNodeFLDR_._src_getDirName_:string;
begin
    result:=inherited;
end;

function _tSrcTree_item_fsNodeFLDR_._src_getObjName_:string;
var tmp:string;
begin
    tmp:=src_DirName;
    if srcTree_fsFnk_FileIsInPath(_item_Text_,tmp)
    then result:= srcTree_fsFnk_CreateRelativePath(_item_Text_,tmp)
    else result:=_item_Text_;
end;

//------------------------------------------------------------------------------

function _tSrcTree_item_fsNodeFLDR_._get_ItemName_:string;
begin
    result:=_src_getObjName_;
end;

//==============================================================================

function _tSrcTree_item_fsNodeFILE_._get_ItemName_:string;
begin
    result:=_src_getObjName_;
end;

function _tSrcTree_item_fsNodeFILE_._src_getDirName_:string;
begin
    result:=inherited;
end;

function _tSrcTree_item_fsNodeFILE_._src_getObjName_:string;
begin
    result:=srcTree_fsFnk_ExtractFileName(_item_Text_);
end;*)

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~[_tSrcTree_item_fsBaseDIR_]

function _tSrcTree_item_fsBaseDIR_._get_ItemName_:string;
begin
    result:=_fsPath_get_;
end;

function _tSrcTree_item_fsBaseDIR_._fsPath_get_:string;
begin
    result:=_item_Text_;
end;

end.

