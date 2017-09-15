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
  private
    function __src_getDirName__:string;  inline;
    function __src_getDirName_abs_:string;  inline;
    function __src_getObjName__:string;  inline;
    function __src_getPath__   :string;  inline;
    function __src_getPath_abs_:string;  inline;
    function __src_isABSOLUTE__:boolean; inline;
  protected
    function  _src_getDirName_ :string;  virtual;
    function  _src_getDirName_abs_:string;  virtual;
    function  _src_getObjName_ :string;  virtual;
  protected
    function  _get_ItemHint_:string;     override;
  public
    property   src_Absolute :boolean read __src_isABSOLUTE__;
    property   src_PATH     :string  read __src_getPath__;    // полный путь (src_Dir+'/'+src_Name)
    property   src_DirName  :string  read __src_getDirName__; // название директории в которой распологаемся (НЕ ДОЛЖЕН содержать завершающий '/')
    property   src_Name     :string  read __src_getObjName__; // наше СОБСТВЕННОЕ название
  public
    property   src_abs_PATH   :string  read __src_getPath_abs_;    // полный путь (src_Dir+'/'+src_Name)
    property   src_abs_DirName:string  read __src_getDirName_abs_; // название директории в которой распологаемся (НЕ ДОЛЖЕН содержать завершающий '/')
  public
    constructor Create(const Text:string); override;
  end;

 _tSrcTree_item_fsNodeFILE_=class(_tStcTree_item_fsNode_)
  protected
    function _get_ItemName_:string; override;
  protected
    function _src_getDirName_:string; override;
    function _src_getObjName_:string; override;
  end;

 _tSrcTree_item_fsNodeFLDR_=class(_tStcTree_item_fsNode_)
  protected
    function _get_ItemName_:string; override;
  protected
    function _src_getDirName_:string; override;
    function _src_getObjName_:string; override;
  end;

 _tSrcTree_item_fsBaseDIR_=class(_tSrcTree_item_fsNodeFLDR_)
   protected
    function _src_getDirName_abs_:string; override;
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
begin
    inherited Create(srcTree_fsFnk_ChompPathDelim(Text));
end;

//------------------------------------------------------------------------------

function _tStcTree_item_fsNode_.__src_getDirName__:string;
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
    result:=srcTree_fsFnk_FilenameIsAbsolute(__src_getPath__);
end;

//------------------------------------------------------------------------------

function _tStcTree_item_fsNode_._src_getDirName_:string;
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
end;

//------------------------------------------------------------------------------

function _tStcTree_item_fsNode_._get_ItemHint_:string;
begin
    result:=src_PATH;
end;

//==============================================================================

function _tSrcTree_item_fsNodeFLDR_._src_getDirName_:string;
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
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~[_tSrcTree_item_fsBaseDIR_]

function _tSrcTree_item_fsBaseDIR_._src_getDirName_abs_:string;
begin
    result:=_item_Text_;
end;

end.

