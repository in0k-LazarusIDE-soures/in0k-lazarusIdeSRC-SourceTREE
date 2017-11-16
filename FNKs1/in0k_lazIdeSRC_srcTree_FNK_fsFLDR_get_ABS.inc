// function SrcTree_getFsFldrABS(const item:tSrcTree_ROOT; const Path:string; const crtFnc:xSrcTree_crtFLDR_4PathABS_callBACK):_tSrcTree_item_fsNodeFLDR_;
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL');
      Assert(srcTree_fsFnk_pathIsAbsolute(Path),'Path Is NOT Absolute.');
      Assert(Assigned(crtFLDR),'crtFnc Is NIL');
    {$endIf}
    result:=tSrcTree_fsFLDR(SrcTree_fndFsFldrABS(item,Path));
    if not Assigned(result) then begin
        // проверим БАЗОВУЮ ... может в ней искать нада
        result:=tSrcTree_fsFLDR(_tSrcTree_item_fsNodeFLDR_(SrcTree_fndBaseDIR(item)));
        if Assigned(Result) and (srcTree_fsFnk_FileIsInPath(Path,tSrcTree_BASE(_tSrcTree_item_fsNodeFLDR_(result)).fsPath))
        then begin // ну точно ... в ней надо
            result:=tSrcTree_fsFLDR(SrcTree_getFsFldrREL(tSrcTree_BASE(_tSrcTree_item_fsNodeFLDR_(result)), srcTree_fsFnk_CreateRelativePath(Path,tSrcTree_BASE(_tSrcTree_item_fsNodeFLDR_(result)).fsPath),crtFLDR));
        end;
        if not Assigned(result) then begin
            // таки НАДО создавать ... и вставлять ПРЯМО в КОРЕНЬ !!!
            result:=SrcTree_add_FsFLDR(item,path,crtFLDR);
        end;
     end;
end;

