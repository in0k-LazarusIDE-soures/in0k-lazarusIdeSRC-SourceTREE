unit in0k_lazIdeSRC_srcTree_4Package;

{$mode objfpc}{$H+}

interface

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.


{$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}
    {$define _DEBUG_}
{$endIf}

uses {$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}
        in0k_lazIdeSRC_DEBUG,
        sysutils,
     {$endIf}

   //LazFileUtils,
   //FileUtil,
   in0k_lazIdeSRC_srcTree_CORE_item,
   //srcTree_item_baseDIR,
   in0k_lazIdeSRC_srcTree_item_Globals,
   in0k_lazIdeSRC_srcTree_CORE_fileSystem_FNK,
   in0k_lazIdeSRC_srcTree_CORE_filePkgType_FNK,
   srcTree_builder_CORE,
   //srcTree_item_coreFileSystem,
   in0k_lazIdeSRC_srcTree_item_fsFolder,
   in0k_lazIdeSRC_srcTree_item_fsFile,

        //srcTree_FNC,

        in0k_lazIdeSRC_srcTree_FNK_baseDIR_GET,
        in0k_lazIdeSRC_srcTree_FNK_baseDIR_SET,
        in0k_lazIdeSRC_srcTree_FNK_mainFILE_SET,
        in0k_lazIdeSRC_srcTree_FNK_fsFILE_ADD,
        in0k_lazIdeSRC_srcTree_FNK_fsFILE_GET,
        in0k_lazIdeSRC_srcTree_FNK_srchPATH_ADD,
        //srcTree_fnd_relPATH,

   PackageIntf;



type

 tSrcTree_Builder_4Package=class(tSrcTree_Builder_CORE)
  protected
    function new_ROOT(const name:string):tSrcTree_ROOT;   override;
    function new_Main(const name:string):tSrcTree_MAIN;   override;
  end;

 tSrcTree_Creater_4Package=class(tSrcTree_Creater)
  protected
    function  get_ROOT_name(const MainOBJ:pointer):string; override;
    function  get_BASE_path(const MainOBJ:pointer):string; override;
    function  get_MAIN_name(const MainOBJ:pointer):string; override;
  protected
    function  get_SrchPTHs (const MainOBJ:pointer; const kind:eSrcTree_SrchPath):string; override;
    procedure set_FileITMs (const MainOBJ:pointer);override;
  end;


 (*
  protected
    //function Crt_BaseDIR (const MainOBJ:pointer; const ROOT:tSrcTree_ROOT):tSrcTree_BASE; override;
  protected
    function Set_ROOT(const mOBJ:pointer                          ):tSrcTree_ROOT; override;
    function Set_Base(const mOBJ:pointer; const ROOT:tSrcTree_ROOT):tSrcTree_BASE; override;
    function Set_Main(const mOBJ:pointer; const ROOT:tSrcTree_ROOT):tSrcTree_MAIN; override;
  protected
    function Add_PATH(const mOBJ:pointer; const ROOT:tSrcTree_ROOT; const Path:eSrcTree_SrchPath; const DirPath:string):tSrcTree_fsFLDR; override;
    function Get_PTHs(const mOBJ:pointer; const ROOT:tSrcTree_ROOT; const Path:eSrcTree_SrchPath):string;    override;
  protected
    function Add_FILE(const mOBJ:pointer; const ROOT:tSrcTree_ROOT; const fileName:string; const fileKind:TPkgFileType):tSrcTree_fsFILE; override;
    function Set_ITMs(const mOBJ:pointer; const ROOT:tSrcTree_ROOT):string;        override;


    //function _make_SourceTREE_root_(const MainOBJ:pointer):tSrcTree_ROOT; override;
  end; *)




//function srcTree_builder_4Package_MAKE(const Package:TIDEPackage):tSrcTree_Root4Package;

//function srcTree_builder_4Package_MAKE(const Package:TIDEPackage; const nodeCreator:pSrcTree_builder_nodeCreator):tSrcTree_Root4Package;


implementation

function tSrcTree_Builder_4Package.new_ROOT(const name:string):tSrcTree_ROOT;
begin
    result:=tSrcTree_Root4Package.Create(name);
end;

function tSrcTree_Builder_4Package.new_Main(const name:string):tSrcTree_MAIN;
begin
    result:=tSrcTree_Main4Package.Create(name);
end;

//------------------------------------------------------------------------------

function tSrcTree_Creater_4Package.get_ROOT_name(const MainOBJ:pointer):string;
begin
    result:=TIDEPackage(MainOBJ).Name;
end;

function tSrcTree_Creater_4Package.get_BASE_path(const MainOBJ:pointer):string;
begin
    result:=TIDEPackage(MainOBJ).DirectoryExpanded;
end;

function tSrcTree_Creater_4Package.get_MAIN_name(const MainOBJ:pointer):string;
begin
    result:=TIDEPackage(MainOBJ).Filename;
end;

//------------------------------------------------------------------------------

function tSrcTree_Creater_4Package.get_SrchPTHs(const MainOBJ:pointer; const kind:eSrcTree_SrchPath):string;
begin
    case kind of
        SrcTree_SrchPath__Fu: result:=TIDEPackage(MainOBJ).LazCompilerOptions.OtherUnitFiles;
        SrcTree_SrchPath__Fi: result:=TIDEPackage(MainOBJ).LazCompilerOptions.IncludePath;
        SrcTree_SrchPath__Fl: result:=TIDEPackage(MainOBJ).LazCompilerOptions.Libraries;
        else result:='';
    end;
end;

//------------------------------------------------------------------------------

procedure tSrcTree_Creater_4Package.set_FileITMs(const MainOBJ:pointer);
var i:integer;
   fn:string;
   ft:eSrcTree_FileType;
begin
    for i:=0 to TIDEPackage(MainOBJ).FileCount-1 do begin
        with TIDEPackage(MainOBJ).Files[i] do begin
            fn:=TIDEPackage(MainOBJ).Files[i].GetShortFilename(false);
            ft:=srcTree_ftPkg_FileNameToPkgFileType(fn);
            add_FileITEM(fn,ft)

(*
            f :=setAdd_FILE(mOBJ,ROOT, fn,ft);

            {$ifDef _DEBUG_}
                if ft<>TIDEPackage(mOBJ).Files[i].FileType then begin
                    DEBUG('Set_ITMs','WRONG fileTypeINC [my].'+srcTree_ftPkg_PkgFileTypeToString(ft)+' vs '+srcTree_ftPkg_PkgFileTypeToString(TIDEPackage(mOBJ).Files[i].FileType)+ ' for '+'"'+fn+'"');
                end;
            {$endIf}
            {$ifDef _DEBUG_}
                DEBUG('Set_ITMs','add File'+'('+srcTree_ftPkg_PkgFileTypeToString(f.fileKIND)+':'+f.ClassName+')'+':'+'"'+f.fsPath+'"'+' from:"'+fn+'"');
            {$endIf}

            {todo: function TPackageEditorForm.OnTreeViewGetImageIndex(Str: String; Data: TObject; var AIsEnabled: Boolean): Integer; }

            {
                fldr:=tSrcTree_fsFLDR(SrcTreeROOT_fnd_relPATH(result,ExtractFileDir(S)));
                DEBUG('addFile',Filename);
                if Assigned(fldr) then begin
                    flNd:=tSrcTree_fsFILE.Create(s,Package.Files[i].FileType);
                    srcTree_builder_add_FileNode(result,fldr,flNd);
    						end
                else DEBUG('addFile','not found '+'"'+ExtractFileDir(S)+'"');
    				end;
    		end;    f   }*)

        end;

    end;
end;



//------------------------------------------------------------------------------
(*
function tSrcTree_Builder_4Package.Set_ROOT(const mOBJ:pointer):tSrcTree_ROOT;
begin
    result:=new_ROOT(TIDEPackage(mOBJ).Name);
end;

function tSrcTree_Builder_4Package.Set_Base(const mOBJ:pointer; const ROOT:tSrcTree_ROOT):tSrcTree_BASE;
begin
    result:=SrcTree_setBaseDIR(ROOT, TIDEPackage(mOBJ).DirectoryExpanded, @new_Base);
end;

function tSrcTree_Builder_4Package.Set_Main(const mOBJ:pointer; const ROOT:tSrcTree_ROOT):tSrcTree_MAIN;
begin
    result:=SrcTree_setMainFILE(ROOT, TIDEPackage(mOBJ).Filename, @new_Main,@new_Base);
end;

//------------------------------------------------------------------------------

function tSrcTree_Builder_4Package.Add_PATH(const mOBJ:pointer; const ROOT:tSrcTree_ROOT; const Path:eSrcTree_SrchPath; const DirPath:string):tSrcTree_fsFLDR;
begin
    result:=tSrcTree_fsFLDR(srcTree_builder_add_SrchPATH(ROOT,DirPath,Path, @new_FLDR));

end;

function tSrcTree_Builder_4Package.Get_PTHs(const mOBJ:pointer; const ROOT:tSrcTree_ROOT; const Path:eSrcTree_SrchPath):string;
begin
    case Path of
        SrcTree_SrchPath__Fu: result:=TIDEPackage(mOBJ).LazCompilerOptions.OtherUnitFiles;
        SrcTree_SrchPath__Fi: result:=TIDEPackage(mOBJ).LazCompilerOptions.IncludePath;
        SrcTree_SrchPath__Fl: result:=TIDEPackage(mOBJ).LazCompilerOptions.Libraries;
        else result:='';
    end;
end;

//------------------------------------------------------------------------------

function tSrcTree_Builder_4Package.Add_FILE(const mOBJ:pointer; const ROOT:tSrcTree_ROOT; const fileName:string; const fileKind:TPkgFileType):tSrcTree_fsFILE;
begin
    result:=tSrcTree_fsFILE(SrcTree_getFsFILE(ROOT, fileName,fileKind, @new_FILE,@new_FLDR));
//    result:=tSrcTree_fsFILE(SrcTree_addNodeFILE(ROOT, fileName,fileKind, @new_FILE,@new_FLDR));
end;

function tSrcTree_Builder_4Package.Set_ITMs(const mOBJ:pointer; const ROOT:tSrcTree_ROOT):string;
var i:integer;
   fn:string;
   ft:TPkgFileType;
    f:tSrcTree_fsFILE;
begin
    for i:=0 to TIDEPackage(mOBJ).FileCount-1 do begin
        with TIDEPackage(mOBJ).Files[i] do begin
            fn:=TIDEPackage(mOBJ).Files[i].GetShortFilename(false);
            ft:=srcTree_ftPkg_FileNameToPkgFileType(fn);
            f :=Add_FILE(mOBJ,ROOT, fn,ft);
            {todo: function TPackageEditorForm.OnTreeViewGetImageIndex(Str: String; Data: TObject; var AIsEnabled: Boolean): Integer; }
            {$ifDef _DEBUG_}
                if ft<>TIDEPackage(mOBJ).Files[i].FileType then begin
                    DEBUG('Set_ITMs','WRONG fileTypeINC [my].'+srcTree_ftPkg_PkgFileTypeToString(ft)+' vs '+srcTree_ftPkg_PkgFileTypeToString(TIDEPackage(mOBJ).Files[i].FileType)+ ' for '+'"'+fn+'"');
                end;
            {$endIf}
            {$ifDef _DEBUG_}
                DEBUG('Set_ITMs','add File'+'('+srcTree_ftPkg_PkgFileTypeToString(f.fileKIND)+':'+f.ClassName+')'+':'+'"'+f.fsPath+'"'+' from:"'+fn+'"');
            {$endIf}

            {
                fldr:=tSrcTree_fsFLDR(SrcTreeROOT_fnd_relPATH(result,ExtractFileDir(S)));
                DEBUG('addFile',Filename);
                if Assigned(fldr) then begin
                    flNd:=tSrcTree_fsFILE.Create(s,Package.Files[i].FileType);
                    srcTree_builder_add_FileNode(result,fldr,flNd);
    						end
                else DEBUG('addFile','not found '+'"'+ExtractFileDir(S)+'"');
    				end;
    		end;    f   }

        end;

    end;
end;

//------------------------------------------------------------------------------



{function srcTree_builder_4Package_MAKE(const Package:TIDEPackage; const nodeCreator:pSrcTree_builder_nodeCreator):tSrcTree_Root4Package;
begin

end;}

{function srcTree_builder_4Package_MAKE(const Package:TIDEPackage):tSrcTree_Root4Package;
var i:integer;
    s:string;
  fldr:tSrcTree_fsFLDR;
  flNd:tSrcTree_fsFILE;
begin
   (* {$ifOpt D+}Assert(Assigned(Package),'Package is NILL');{$endIf}

    //--------------
    {$ifDef _DEBUG_}DEBUG('srcTree_builder_4Package_MAKE','START at '+DateTimeToStr(NOW));{$endIf}
    //--------------

    {$ifDef _DEBUG_}DEBUG('srcTree_builder_4Package_MAKE','create Root4Package');{$endIf}
    result:=tSrcTree_Root4Package.Create(Package.Name);
    //--- пробиваем БАЗОВЫЙ путь
    {$ifDef _DEBUG_}DEBUG('srcTree_builder_4Package_MAKE','set BaseDIR="'+Package.DirectoryExpanded+'"');{$endIf}
    SrcTreeROOT_set_BaseDIR(result,Package.DirectoryExpanded);
    //--- главный файл
    {$ifDef _DEBUG_}DEBUG('srcTree_builder_4Package_MAKE','add MainFILE="'+Package.Filename+'"');{$endIf}
    srcTree_builder_add_MainFILE(result,tSrcTree_Main4Package.Create(Package.Filename));
    //--- пробиваем пути поиска
    {$ifDef _DEBUG_}DEBUG('srcTree_builder_4Package_MAKE','add Search Paths');{$endIf}
    srcTree_builder_add_SearchPATH_DirLIST(result,Package.LazCompilerOptions.OtherUnitFiles,SrcTree_SrchPath__Fu);
    srcTree_builder_add_SearchPATH_DirLIST(result,Package.LazCompilerOptions.IncludePath   ,SrcTree_SrchPath__Fi);
    srcTree_builder_add_SearchPATH_DirLIST(result,Package.LazCompilerOptions.Libraries     ,SrcTree_SrchPath__Fl);
    //--- пробиваем файлы проэкта
    {$ifDef _DEBUG_}DEBUG('srcTree_builder_4Package_MAKE','add used files');{$endIf}
    for i:=0 to Package.FileCount-1 do begin
        with Package.Files[i] do begin
            S:=Package.Files[i].GetShortFilename(false);
            fldr:=tSrcTree_fsFLDR(SrcTreeROOT_fnd_relPATH(result,ExtractFileDir(S)));
            DEBUG('addFile',Filename);
            if Assigned(fldr) then begin
                flNd:=tSrcTree_fsFILE.Create(s,Package.Files[i].FileType);
                srcTree_builder_add_FileNode(result,fldr,flNd);
						end
            else DEBUG('addFile','not found '+'"'+ExtractFileDir(S)+'"');
				end;
		end;

    //--------------
    {$ifDef _DEBUG_}DEBUG('srcTree_builder_4Package_MAKE','END at '+DateTimeToStr(NOW));{$endIf}
    //--------------   *)
end;}   *)

end.

