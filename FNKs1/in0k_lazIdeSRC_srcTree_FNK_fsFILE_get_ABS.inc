//function SrcTree_getFsFileABS(const item:tSrcTree_ROOT; const path:string; const fileKind:TPkgFileType; const crtFILE:xSrcTree_crt_FsFILE_callBACK; const crtFLDR:xSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_;
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL');
      Assert(srcTree_fsFnk_pathIsAbsolute(Path),'Path Is NOT Absolute.');
      Assert(Assigned(crtFILE),'crtFILE Is NIL');
      Assert(Assigned(crtFLDR),'crtFLDR Is NIL');
    {$endIf}
    result:=SrcTree_fndFsFileABS(item,Path);
    if not Assigned(result) then begin
        result:=SrcTree_addFsFILE(SrcTree_getFsFldrABS(item,srcTree_fsFnk_ExtractFileDir(path),crtFLDR), Path,fileKind,crtFILE);
    end;
end;

