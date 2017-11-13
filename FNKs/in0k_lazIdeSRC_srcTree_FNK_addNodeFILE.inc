//in0k_srcTree_addNodeFILE
//function SrcTree_addNodeFILE(const item:tSrcTree_ROOT; const fileName:string; const fileKind:TPkgFileType; const crtFnc:fSrcTree_addNodeFILE_crtNodeFILE; const crtRelPATH:fSrcTree_crtRelPATH_callBACK):tSrcTree_fsFILE;
var tmp:tSrcTree_fsFLDR;
begin
    result:=SrcTree_fndFileREL(item, fileName);
    if not Assigned(result) then begin
        tmp:=SrcTree_getPathREL(item, srcTree_fsFnk_ExtractFileDir(fileName), crtRelPATH);
        {$ifOpt D+}Assert(Assigned(tmp));{$endIf}
        result:=crtFnc(fileName, fileKind);
        SrcTree_insert_ChldLast(tmp,result);
    end;
end;

