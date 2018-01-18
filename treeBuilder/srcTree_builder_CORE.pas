unit srcTree_builder_CORE;

{$mode objfpc}{$H+}

interface

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.

uses {$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}
        in0k_lazIdeSRC_DEBUG,
        sysutils,
     {$endIf}
    PackageIntf,
    //
    in0k_lazIdeSRC_srcTree_CORE_item,
    in0k_lazIdeSRC_srcTree_CORE_itemFileSystem,
    in0k_lazIdeSRC_srcTree_item_Globals,
    in0k_lazIdeSRC_srcTree_item_fsFile,
    in0k_lazIdeSRC_srcTree_item_fsFolder,
    //
    in0k_lazIdeSRC_srcTree_CORE_filePkgType_FNK,
    in0k_lazIdeSRC_srcTree_CORE_fromIDEProcs_FNK,
    in0k_lazIdeSRC_srcTree_FNK_baseDIR_FND,
    in0k_lazIdeSRC_srcTree_FNK_baseDIR_GET,
    in0k_lazIdeSRC_srcTree_FNK_baseDIR_SET,

    in0k_lazIdeSRC_srcTree_FNK_mainFILE_FND,
    in0k_lazIdeSRC_srcTree_FNK_mainFILE_GET,
    in0k_lazIdeSRC_srcTree_FNK_mainFILE_SET,

    in0k_lazIdeSRC_srcTree_FNK_fsFLDR_FND,
    in0k_lazIdeSRC_srcTree_FNK_fsFLDR_GET,
    in0k_lazIdeSRC_srcTree_FNK_fsFILE_FND,
    in0k_lazIdeSRC_srcTree_FNK_fsFILE_GET;


type
          //Make
          //Creater
 tSrcTree_Builder_CORE=class
  protected
    function new_ROOT(const name:string):tSrcTree_ROOT;   virtual;
    function new_Base(const path:string):tSrcTree_BASE;   virtual;
    function new_Main(const name:string):tSrcTree_MAIN;   virtual;
    function new_FLDR(const path:string):tSrcTree_fsFLDR; virtual;
    function new_FILE(const path:string):tSrcTree_fsFILE; virtual;
  public
    function fnd_BASE(const ROOT:tSrcTree_ROOT):tSrcTree_BASE;
    function fnd_MAIN(const ROOT:tSrcTree_ROOT):tSrcTree_MAIN;
    function fnd_FLDR(const ROOT:tSrcTree_ROOT; const path:string):tSrcTree_fsFLDR;
    function fnd_FILE(const ROOT:tSrcTree_ROOT; const path:string):tSrcTree_fsFILE;
  public
    function set_BASE(const ROOT:tSrcTree_ROOT; const path:string):tSrcTree_BASE;                                 virtual;
    function set_MAIN(const ROOT:tSrcTree_ROOT; const path:string):tSrcTree_MAIN;                                 virtual;
  public
    function add_FLDR(const ROOT:tSrcTree_ROOT; const path:string; const kind:eSrcTree_SrchPath):tSrcTree_fsFLDR; virtual;
    function add_FLDR(const ROOT:tSrcTree_ROOT; const path:string; const KNDs:sSrcTree_SrchPath):tSrcTree_fsFLDR; virtual;
    function add_FILE(const ROOT:tSrcTree_ROOT; const path:string; const kind:eSrcTree_FileType):tSrcTree_fsFILE; virtual;
  public
    function crt_ROOT(const Name:string):tSrcTree_ROOT;                                                           virtual;
  public
    constructor Create;
  end;
 tSrcTree_Builder_TYPE=class Of tSrcTree_Builder_CORE;

 tSrcTree_Creater=class
  private
   _builder_:tSrcTree_Builder_CORE;
   _rootOBJ_:tSrcTree_ROOT;
  protected
    function  get_ROOT_name(const MainOBJ:pointer):string; virtual;
    function  get_BASE_path(const MainOBJ:pointer):string; virtual;
    function  get_MAIN_name(const MainOBJ:pointer):string; virtual;
  protected
    function  add_SrchPATH (const path:string; const kind:eSrcTree_SrchPath):tSrcTree_fsFLDR;
    procedure add_SrchPTHs (const pths:string; const kind:eSrcTree_SrchPath);
    function  add_FileITEM (const path:string; const kind:eSrcTree_FileType):tSrcTree_fsFILE;
  protected
    function  get_SrchPTHs (const MainOBJ:pointer; const kind:eSrcTree_SrchPath):string; virtual;
    procedure set_SrchPTHs (const MainOBJ:pointer);virtual;
    procedure set_FileITMs (const MainOBJ:pointer);virtual;
  public
    function MAKE_SourceTREE(const Builder:tSrcTree_Builder_CORE; const MainOBJ:pointer):tSrcTree_ROOT;
  end;

 tSrcTree_Creater_TYPE=class Of tSrcTree_Creater;

 {tSrcTree_Builder4LazOBJ=class(tSrcTree_Builder_CORE)
  protected
    function Set_ROOT(const mOBJ:pointer                          ):tSrcTree_ROOT; virtual;
    function Set_Base(const mOBJ:pointer; const ROOT:tSrcTree_ROOT):tSrcTree_BASE; virtual;
    function Set_Main(const mOBJ:pointer; const ROOT:tSrcTree_ROOT):tSrcTree_MAIN; virtual;
  protected
    function Add_PATH(const mOBJ:pointer; const ROOT:tSrcTree_ROOT; const Path:eSrcTree_SrchPath; const DirPath:string):tSrcTree_fsFLDR; virtual;
    function Add_PTHs(const mOBJ:pointer; const ROOT:tSrcTree_ROOT; const Path:eSrcTree_SrchPath; const DirLIST:string):string;    virtual;
    function Get_PTHs(const mOBJ:pointer; const ROOT:tSrcTree_ROOT; const Path:eSrcTree_SrchPath):string;    virtual;
    function Set_PTHs(const mOBJ:pointer; const ROOT:tSrcTree_ROOT):string;        virtual;
  protected
    function Add_FILE(const mOBJ:pointer; const ROOT:tSrcTree_ROOT; const fileName:string; const fileKind:TPkgFileType):tSrcTree_fsFILE; virtual;
    function Set_ITMs(const mOBJ:pointer; const ROOT:tSrcTree_ROOT):string;        virtual;
  protected
    function Crt_fsNodeFLDR(const folderName:string):tSrcTree_fsFLDR;
  public
    function MAKE_SourceTREE(const MainOBJ:pointer):tSrcTree_ROOT;
    //function MAKE_SourceTREE(const Builder:tSrcTree_Builder_CORE; const RootOBJ:tSrcTree_ROOT; const MainOBJ:pointer):;
  public
    //function Add_ROOT(const ROOT:tSrcTree_ROOT; const Name:string):tSrcTree_ROOT;
    function Add_BASE(const ROOT:tSrcTree_ROOT; const Path:string):tSrcTree_BASE;
    function Add_MAIN(const ROOT:tSrcTree_ROOT; const Name:string):tSrcTree_MAIN;
    function Add_FILE(const ROOT:tSrcTree_ROOT; const Path:string; const fileKind:TPkgFileType):tSrcTree_fsFILE;
    function Add_FLDR(const ROOT:tSrcTree_ROOT; const Path:string; const pathKing:eSrcTree_SrchPath):tSrcTree_fsFLDR;
  end;}

//type
// fCrt_Node_ROOT =function(const OBJ:pointer; const ROOT_Name:string):tSrcTree_ROOT;
// fCrt_fsNodeFLDR=function(const OBJ:pointer; const folderName:string):tSrcTree_fsFLDR;

 {rSrcTree_builder_nodeCreator=record
    OBJ:pointer;
    Crt_node_Root:fCrt_Node_ROOT;
    Crt_fsNodeFLDR:fCrt_fsNodeFLDR;
  end;
 pSrcTree_builder_nodeCreator=^rSrcTree_builder_nodeCreator;
  }


//function srcTree_builder__CRT__NodeROOT(const nodeCreator:pSrcTree_builder_nodeCreator; const ROOT_Name:string):tSrcTree_ROOT;




//procedure srcTree_builder_add_MainFILE          (const ROOT:tSrcTree_ROOT; const MAIN:tSrcTree_MAIN);



//procedure srcTree_builder_add_FileNode          (const ROOT:tSrcTree_ROOT; const DirNode:tSrcTree_item_fsNodeFLDR; const FileNode:_tSrcTree_item_fsNodeFILE_);


implementation

{%region --- возня с ДЕБАГОМ -------------------------------------- /fold}
{$if defined(in0k_lazExt_CopyRAST_wndCORE___DebugLOG) AND declared(in0k_lazIde_DEBUG)}
    // `in0k_lazIde_DEBUG` - это функция ИНДИКАТОР что используется
    //                       моя "система имен и папок"
    {$define _debug_}     //< типа да ... можно делать ДЕБАГ отметки
{$else}
    {$undef _debug_}
{$endIf}
{%endregion}

{constructor tSrcTree_Builder4LazOBJ.Create(const MainOBJ:pointer);
begin
  // _mainOBJ_:=MainOBJ;
end;}


constructor tSrcTree_Builder_CORE.Create;
begin
    inherited;
end;

//------------------------------------------------------------------------------

function tSrcTree_Builder_CORE.new_ROOT(const name:string):tSrcTree_ROOT;
begin // чисто для примера! переОПРЕдЕЛИТЬ в наследниках!
    result:=tSrcTree_ROOT.Create(name);//NIL;//tSrcTree_ROOT.Create(rootName);
end;

function tSrcTree_Builder_CORE.new_Base(const path:string):tSrcTree_BASE;
begin // чисто для примера! переОПРЕдЕЛИТЬ в наследниках!
    result:=tSrcTree_BASE.Create(path);//nil;
end;

function tSrcTree_Builder_CORE.new_Main(const name:string):tSrcTree_MAIN;
begin // чисто для примера! переОПРЕдЕЛИТЬ в наследниках!
    result:=tSrcTree_MAIN.Create(name);//nil;
end;

function tSrcTree_Builder_CORE.new_FLDR(const path:string):tSrcTree_fsFLDR;
begin // чисто для примера! переОПРЕдЕЛИТЬ в наследниках!
    result:=tSrcTree_fsFLDR.Create(path);
end;

function tSrcTree_Builder_CORE.new_FILE(const path:string):tSrcTree_fsFILE;
begin // чисто для примера! переОПРЕдЕЛИТЬ в наследниках!
    result:=tSrcTree_fsFILE.Create(path);
end;

//------------------------------------------------------------------------------

function tSrcTree_Builder_CORE.fnd_BASE(const ROOT:tSrcTree_ROOT):tSrcTree_BASE;
begin
    {$ifDef _DEBUG_}Assert(Assigned(Root));{$endIf}
    result:=SrcTree_fndBaseDIR(ROOT);
end;

function tSrcTree_Builder_CORE.fnd_MAIN(const ROOT:tSrcTree_ROOT):tSrcTree_MAIN;
begin
    {$ifDef _DEBUG_}Assert(Assigned(Root));{$endIf}
    result:=SrcTree_fndMainFILE(ROOT);
end;

function tSrcTree_Builder_CORE.fnd_FLDR(const ROOT:tSrcTree_ROOT; const path:string):tSrcTree_fsFLDR;
begin
    {$ifDef _DEBUG_}Assert(Assigned(Root));{$endIf}
    result:=tSrcTree_fsFLDR(SrcTree_fndFsFLDR(ROOT,path));
    if not (tObject(result) is tSrcTree_fsFLDR) {todo: ПРОВЕИТЬ, сомнительно все это}
    then result:=NIL;
end;

function tSrcTree_Builder_CORE.fnd_FILE(const ROOT:tSrcTree_ROOT; const path:string):tSrcTree_fsFILE;
begin
    {$ifDef _DEBUG_}Assert(Assigned(Root));{$endIf}
    result:=tSrcTree_fsFILE(SrcTree_fndFsFile(ROOT,path));
    if not (tObject(result) is tSrcTree_fsFILE) {todo: ПРОВЕИТЬ, сомнительно все это}
    then result:=NIL;
end;

//------------------------------------------------------------------------------

function tSrcTree_Builder_CORE.set_BASE(const ROOT:tSrcTree_ROOT; const path:string):tSrcTree_BASE;
begin
    {$ifDef _DEBUG_}Assert(Assigned(Root));{$endIf}
    result:=SrcTree_setBaseDIR(ROOT,path,@new_Base);
end;

function tSrcTree_Builder_CORE.set_MAIN(const ROOT:tSrcTree_ROOT; const path:string):tSrcTree_MAIN;
begin
    {$ifDef _DEBUG_}Assert(Assigned(Root));{$endIf}
    result:=SrcTree_setMainFILE(ROOT,path,@new_Main,@new_Base);
end;

function tSrcTree_Builder_CORE.add_FLDR(const ROOT:tSrcTree_ROOT; const path:string; const kind:eSrcTree_SrchPath):tSrcTree_fsFLDR;
begin
    {$ifDef _DEBUG_}Assert(Assigned(Root));{$endIf}
    result:=tSrcTree_fsFLDR(SrcTree_getFsFLDR(ROOT,path,@new_FLDR));
    if not (tObject(result) is tSrcTree_fsFLDR) {todo: ПРОВЕИТЬ, сомнительно все это}
    then result:=NIL
    else begin
        SrcTree_fsFolder__addSearchPATH(result,kind);
    end;
end;

function tSrcTree_Builder_CORE.add_FLDR(const ROOT:tSrcTree_ROOT; const path:string; const KNDs:sSrcTree_SrchPath):tSrcTree_fsFLDR;
begin
    {$ifDef _DEBUG_}Assert(Assigned(Root));{$endIf}
    result:=tSrcTree_fsFLDR(SrcTree_getFsFLDR(ROOT,path,@new_FLDR));
    if not (tObject(result) is tSrcTree_fsFLDR) {todo: ПРОВЕИТЬ, сомнительно все это}
    then result:=NIL
    else begin
        SrcTree_fsFolder__addSearchPATH(result,KNDs);
    end;
end;

function tSrcTree_Builder_CORE.add_FILE(const ROOT:tSrcTree_ROOT; const path:string; const kind:eSrcTree_FileType):tSrcTree_fsFILE;
begin
    {$ifDef _DEBUG_}Assert(Assigned(Root));{$endIf}
    result:=tSrcTree_fsFILE(SrcTree_getFsFILE(ROOT,path,@new_FILE,@new_FLDR));
    if not (tObject(result) is tSrcTree_fsFILE) {todo: ПРОВЕИТЬ, сомнительно все это}
    then result:=NIL
    else begin
        SrcTree_fsFILE__set_FileKIND(result,kind);
    end;
end;

//------------------------------------------------------------------------------

function tSrcTree_Builder_CORE.crt_ROOT(const Name:string):tSrcTree_ROOT;
begin
    result:=new_ROOT(Name);
end;


//==============================================================================


function tSrcTree_Creater.get_ROOT_name(const MainOBJ:pointer):string;
begin

end;

function tSrcTree_Creater.get_BASE_path(const MainOBJ:pointer):string;
begin

end;

function tSrcTree_Creater.get_MAIN_name(const MainOBJ:pointer):string;
begin

end;

//------------------------------------------------------------------------------

procedure tSrcTree_Creater.add_SrchPTHs(const pths:string; const kind:eSrcTree_SrchPath);
var StartPos:Integer;
    singlDir:string;
begin
    StartPos:=1;
    singlDir:=GetNextDirectoryInSearchPath(pths,StartPos);
    while singlDir<>'' do begin
        add_SrchPATH(singlDir,kind);
        singlDir:=GetNextDirectoryInSearchPath(pths,StartPos);
    end;
end;

function tSrcTree_Creater.add_SrchPATH(const path:string; const kind:eSrcTree_SrchPath):tSrcTree_fsFLDR;
begin
    result:=_builder_.add_FLDR(_rootOBJ_,path,kind);
    {$ifDef _DEBUG_}DEBUG('add_SrchPATH','('+result.ClassName+')'+':'+'"'+result.fsPath+'"'+' type['+SrcTree_fsFolder__SrchPTHs2TEXT(result)+']'+' from:"'+path+'"');{$endIf}
end;

function tSrcTree_Creater.add_FileITEM(const path:string; const kind:eSrcTree_FileType):tSrcTree_fsFILE;
var ft:eSrcTree_FileType;
begin
    ft:=srcTree_ftPkg_FileNameToPkgFileType(path);
    result:=_builder_.add_FILE(_rootOBJ_,path,ft);
    {$ifDef _DEBUG_}
        if ft<>kind then begin
            DEBUG('add_FileITEM','WRONG fileTypeINC [my].'+srcTree_ftPkg_PkgFileTypeToString(ft)+' vs '+srcTree_ftPkg_PkgFileTypeToString(kind)+ ' for '+'"'+path+'"');
        end;
    {$endIf}
    {$ifDef _DEBUG_}
        DEBUG('add_FileITEM','('+result.ClassName+')'+':'+'"'+result.fsPath+'"'+' type['+srcTree_ftPkg_PkgFileTypeToString(result.fileKIND)+']'+' from:"'+path+'"');
    {$endIf}

end;

//------------------------------------------------------------------------------

function tSrcTree_Creater.get_SrchPTHs(const MainOBJ:pointer; const kind:eSrcTree_SrchPath):string;
begin
    result:='';
end;

procedure tSrcTree_Creater.set_SrchPTHs(const MainOBJ:pointer);
var PathKIND:eSrcTree_SrchPath;
begin
    for PathKIND:=Low(eSrcTree_SrchPath) to High(eSrcTree_SrchPath) do begin
        add_SrchPTHs(get_SrchPTHs(MainOBJ,PathKIND),PathKIND);
    end;
end;

procedure tSrcTree_Creater.set_FileITMs(const MainOBJ:pointer);
begin

end;

//------------------------------------------------------------------------------

function tSrcTree_Creater.MAKE_SourceTREE(const Builder:tSrcTree_Builder_CORE; const MainOBJ:pointer):tSrcTree_ROOT;
begin
   _builder_:=Builder;
    //--------------
    {$ifDef _DEBUG_}DEBUG('MAKE_SourceTREE','START at '+DateTimeToStr(NOW)+' for MainOBJ'+addr2txt(MainOBJ));{$endIf}
    //--------------

    //--- создаем файл ROOT
    result:=Builder.crt_ROOT( get_ROOT_name(MainOBJ) );//  Set_ROOT(MainOBJ);
    {$ifDef _DEBUG_}DEBUG('MAKE_SourceTREE','create Root'+'('+result.ClassName+')'+':'+'"'+result.ItemNAME+'"');{$endIf}
   _rootOBJ_:=result;

    //--- пробиваем БАЗОВЫЙ путь
    Builder.set_BASE(result, get_BASE_path(MainOBJ) );//Set_Base(MainOBJ,result);
    {$ifDef _DEBUG_}DEBUG('MAKE_SourceTREE','set BaseDIR'+'('+SrcTree_fndBaseDIR(result).ClassName+')'+':'+'"'+SrcTree_fndBaseDIR(result).fsPath+'"');{$endIf}

    //--- пробиваем ГЛАВНЫЙ файл
    Builder.set_MAIN(result, get_MAIN_name(MainOBJ) );// Set_Main(MainOBJ,result);
    {$ifDef _DEBUG_}DEBUG('MAKE_SourceTREE','set MainFILE'+'('+SrcTree_fndMainFILE(result).ClassName+')'+':'+'"'+SrcTree_fndMainFILE(result).ItemNAME+'"');{$endIf}

    //--- пробиваем Пути ПОИСКА
    {$ifDef _DEBUG_}DEBUG('MAKE_SourceTREE','add SrchPATH ....');{$endIf}
    set_SrchPTHs(MainOBJ);
    {$ifDef _DEBUG_}DEBUG('MAKE_SourceTREE','add SrchPATH end.');{$endIf}
    //--- добавляем файлы указанные в проекте
    {$ifDef _DEBUG_}DEBUG('MAKE_SourceTREE','add File ITMs ....');{$endIf}
    set_FileITMs(MainOBJ);
    {$ifDef _DEBUG_}DEBUG('MAKE_SourceTREE','add File ITMs end.');{$endIf}


    //--------------
    {$ifDef _DEBUG_}DEBUG('MAKE_SourceTREE','END at '+DateTimeToStr(NOW)+' for MainOBJ'+addr2txt(MainOBJ));{$endIf}
    //--------------
   _builder_:=nil;
   _rootOBJ_:=nil;
end;



{function tSrcTree_Builder_CORE.get_ROOT(const ROOT:tSrcTree_ROOT):tSrcTree_ROOT;
begin
    result:=ROOT;
end;}

{function tSrcTree_Builder_CORE.get_BASE(const ROOT:tSrcTree_ROOT):tSrcTree_BASE;
begin
    result:=SrcTree_fndBaseDIR(ROOT);
end;}

{function tSrcTree_Builder_CORE.get_MAIN(const ROOT:tSrcTree_ROOT):tSrcTree_MAIN;
}

(*
function tSrcTree_Builder_CORE.set_ROOT(const ROOT:tSrcTree_ROOT; const name:string):tSrcTree_ROOT;
begin
    if Assigned(ROOT) then begin
        result:=ROOT;
        SrcTree_re_set_itemTEXT(result,name);
    end
    else begin
        result:=new_ROOT(name);
    end;
end;

function tSrcTree_Builder_CORE.set_BASE(const ROOT:tSrcTree_ROOT; const name:string):tSrcTree_BASE;
begin
    result:=SrcTree_getBaseDIR//(ROOT,);


    if not Assigned(result) then result:=
end;

function tSrcTree_Builder_CORE.set_MAIN(const ROOT:tSrcTree_ROOT; const name:string):tSrcTree_MAIN;

*)



{function tSrcTree_Builder4LazOBJ.new_Base(const BaseDIR_PATH:string):tSrcTree_BASE;
begin
    result:=tSrcTree_BASE.Create(BaseDIR_PATH);
end;}

(*
function tSrcTree_Builder4LazOBJ.Crt_fsNodeFLDR(const folderName:string):tSrcTree_fsFLDR;
begin
    result:=new_FLDR(folderName);
end;

{function tSrcTree_Builder4LazOBJ._make_SourceTREE_root_(const MainOBJ:pointer):tSrcTree_ROOT;
begin
    result:=Crt_RootNODE('');
end;}

function tSrcTree_Builder4LazOBJ.Set_ROOT(const mOBJ:pointer):tSrcTree_ROOT;
begin
    result:=nil;
end;

function tSrcTree_Builder4LazOBJ.Set_Base(const mOBJ:pointer; const ROOT:tSrcTree_ROOT):tSrcTree_BASE;
begin
    result:=nil;
end;

function tSrcTree_Builder4LazOBJ.Set_Main(const mOBJ:pointer; const ROOT:tSrcTree_ROOT):tSrcTree_MAIN;
begin
    result:=nil;
end;

//------------------------------------------------------------------------------

function tSrcTree_Builder4LazOBJ.Add_PATH(const mOBJ:pointer; const ROOT:tSrcTree_ROOT; const Path:eSrcTree_SrchPath; const DirPath:string):tSrcTree_fsFLDR;
begin
    //result:=srcTree_builder_add_SearchPATH_DirNAME(mOBJ,DirPath,Path, @new_FLDR);

    //
end;

function tSrcTree_Builder4LazOBJ.Add_PTHs(const mOBJ:pointer;  const ROOT:tSrcTree_ROOT; const Path:eSrcTree_SrchPath; const DirLIST:string):string;
var StartPos:Integer;
    singlDir:string;
    tmpFLDR :tSrcTree_fsFLDR;
begin
    //{$ifDef _debug_}DEBUG('srcTree_builder_add_SearchPATH_DirLIST','PathKIND="'+SrcTree_SrchPathKIND_2_Text(PathKIND)+'"'+' DirLIST="'+DirLIST+'"');{$endIf}
    StartPos:=1;
    singlDir:=GetNextDirectoryInSearchPath(DirLIST,StartPos);
        while singlDir<>'' do begin
            tmpFLDR:=Add_PATH(mOBJ,ROOT,Path,singlDir);
            {$ifDef _DEBUG_}DEBUG('MAKE_SourceTREE','add SrchPATH'+'('+tmpFLDR.ClassName+')'+':'+'"'+tmpFLDR.fsPath+'"'+' type['+SrcTree_fsFolder__SrchPTHs2TEXT(tmpFLDR)+']');{$endIf}
            //-->
            singlDir:=GetNextDirectoryInSearchPath(DirLIST,StartPos);
        end;
   // end;
end;

function tSrcTree_Builder4LazOBJ.Get_PTHs(const mOBJ:pointer; const ROOT:tSrcTree_ROOT; const Path:eSrcTree_SrchPath):string;
begin
    result:='';
end;

function tSrcTree_Builder4LazOBJ.Set_PTHs(const mOBJ:pointer; const ROOT:tSrcTree_ROOT):string;
var PathKIND:eSrcTree_SrchPath;
begin
    for PathKIND:=Low(eSrcTree_SrchPath) to High(eSrcTree_SrchPath) do begin
        //srcTree_builder_add_SearchPATH_DirLIST(ROOT,Get_PTHs(mOBJ,PathKIND),PathKIND,@new_FLDR);
        Add_PTHs(mOBJ,ROOT,PathKIND,Get_PTHs(mOBJ,ROOT,PathKIND));
    end;
end;

//------------------------------------------------------------------------------

function tSrcTree_Builder4LazOBJ.Add_FILE(const mOBJ:pointer; const ROOT:tSrcTree_ROOT; const fileName:string; const fileKind:TPkgFileType):tSrcTree_fsFILE;
begin

end;

function tSrcTree_Builder4LazOBJ.Set_ITMs(const mOBJ:pointer; const ROOT:tSrcTree_ROOT):string;
begin

end;

//------------------------------------------------------------------------------

function tSrcTree_Builder4LazOBJ.MAKE_SourceTREE(const MainOBJ:pointer):tSrcTree_ROOT;
begin
    //--------------
    {$ifDef _DEBUG_}DEBUG('MAKE_SourceTREE','START at '+DateTimeToStr(NOW)+' for MainOBJ'+addr2txt(MainOBJ));{$endIf}
    //--------------

    //--- создаем файл ROOT
    result:=Set_ROOT(MainOBJ);
    {$ifDef _DEBUG_}DEBUG('MAKE_SourceTREE','create Root'+'('+result.ClassName+')'+':'+'"'+result.ItemNAME+'"');{$endIf}

    //--- пробиваем БАЗОВЫЙ путь
    Set_Base(MainOBJ,result);
    {$ifDef _DEBUG_}DEBUG('MAKE_SourceTREE','set BaseDIR'+'('+SrcTree_fndBaseDIR(result).ClassName+')'+':'+'"'+SrcTree_fndBaseDIR(result).fsPath+'"');{$endIf}

    //--- пробиваем ГЛАВНЫЙ файл
    Set_Main(MainOBJ,result);
    {$ifDef _DEBUG_}DEBUG('MAKE_SourceTREE','set MainFILE'+'('+SrcTree_fndMainFILE(result).ClassName+')'+':'+'"'+SrcTree_fndMainFILE(result).ItemNAME+'"');{$endIf}

    //--- пробиваем Пути ПОИСКА
    {$ifDef _DEBUG_}DEBUG('MAKE_SourceTREE','add SrchPATH ....');{$endIf}
    Set_PTHs(MainOBJ,result);
    {$ifDef _DEBUG_}DEBUG('MAKE_SourceTREE','add SrchPATH end.');{$endIf}
    //--- добавляем файлы указанные в проекте
    {$ifDef _DEBUG_}DEBUG('MAKE_SourceTREE','add File ITMs ....');{$endIf}
    Set_ITMs(MainOBJ,result);
    {$ifDef _DEBUG_}DEBUG('MAKE_SourceTREE','add File ITMs end.');{$endIf}


    //--------------
    {$ifDef _DEBUG_}DEBUG('MAKE_SourceTREE','END at '+DateTimeToStr(NOW)+' for MainOBJ'+addr2txt(MainOBJ));{$endIf}
    //--------------
end;


//==============================================================================

{function tSrcTree_Builder4LazOBJ.Add_ROOT(const ROOT:tSrcTree_ROOT; const Name:string):tSrcTree_ROOT;
begin
    result:=ROOT;
    SrcTree_re_set_itemTEXT(result,Name);
end;  }

function tSrcTree_Builder4LazOBJ.Add_BASE(const ROOT:tSrcTree_ROOT; const Path:string):tSrcTree_BASE;
begin
    result:=SrcTree_getBaseDIR(ROOT);
    SrcTree_re_set_itemTEXT(result,Path);
end;

function tSrcTree_Builder4LazOBJ.Add_MAIN(const ROOT:tSrcTree_ROOT; const Name:string):tSrcTree_MAIN;
begin
    result:=SrcTree_getMainFILE(ROOT,@new_Main,@new_Base);
    SrcTree_re_set_itemTEXT(result,Name);
end;

function tSrcTree_Builder4LazOBJ.Add_FILE(const ROOT:tSrcTree_ROOT; const fileName:string; const fileKind:TPkgFileType):tSrcTree_fsFILE;
begin
    Add_FILE(nil, ROOT,fileName,fileKind);
end;

function tSrcTree_Builder4LazOBJ.Add_FLDR(const ROOT:tSrcTree_ROOT; const folderPathName:string; const Path:eSrcTree_SrchPath):tSrcTree_fsFLDR;
begin
    Add_PATH(nil,ROOT,Path,folderPathName);
end;



 *)









{function srcTree_builder__CRT__NodeROOT(const nodeCreator:pSrcTree_builder_nodeCreator; const ROOT_Name:string):tSrcTree_ROOT;
begin
    {$IfOpt D+}Assert(Assigned(nodeCreator),'nodeCreator NOT define');{$endIf}
    {$IfOpt D+}Assert(Assigned(nodeCreator^.Crt_node_Root),'nodeCreator^.Crt_node_Root NOT define');{$endIf}
    result:=nodeCreator^.Crt_node_Root(nodeCreator^.OBJ,ROOT_Name);
    {$ifDef _DEBUG_}DEBUG('srcTree_builder__CORE','create Root '+result.ClassName+':'+result.ItemNAME);{$endIf}
end;  }


{procedure srcTree_builder_add_MainFILE(const ROOT:tSrcTree_ROOT; const MAIN:tSrcTree_MAIN);
begin
    {$ifDef _debug_}DEBUG('srcTree_builder_add_MainFILE','MAIN="'+MAIN.ItemTEXT+'"');{$endIf}
    SrcTreeROOT_add_Main(ROOT,MAIN);
end; }

{procedure srcTree_builder_add_FileNode(const ROOT:tSrcTree_ROOT; const DirNode:tSrcTree_fsFLDR; const FileNode:_tSrcTree_item_fsNodeFILE_);
begin
    SrcTreeROOT_add_File(ROOT,DirNode,FileNode);
end;}



end.

