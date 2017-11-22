//function SrcTree_getFsFileREL(const item:_tSrcTree_item_fsNodeFLDR_; const path:string; const fileKind:TPkgFileType; const crtFILE:xSrcTree_crt_FsFILE_callBACK; const crtFLDR:xSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFILE_; overload; {$ifOpt D-}inline;{$endIf}
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL');
      Assert(srcTree_fsFnk_pathIsRelative(Path),'Path Is NOT Relative.');
      Assert(Assigned(crtFILE),'crtFILE Is NIL');
      Assert(Assigned(crtFLDR),'crtFLDR Is NIL');
    {$endIf}
    result:=SrcTree_fndFsFileREL(item,Path);
    if not Assigned(result) then begin
        result:=SrcTree_addFsFILE(SrcTree_getFsFldrREL(item,srcTree_fsFnk_ExtractFileDir(path),crtFLDR), path,{fileKind,}crtFILE);
    end;
end;

