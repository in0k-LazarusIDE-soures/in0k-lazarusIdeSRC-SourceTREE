//function SrcTree_getBaseDIR(const item:tSrcTree_ROOT; const crtFnc:xSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_BASE;
begin
    {$ifOpt D+}Assert(Assigned(item));{$endIf}
    {$ifOpt D+}Assert(Assigned(crtFnc));{$endIf}
    result:=SrcTree_fndBaseDIR(item);
    if not Assigned(result) then begin //< ничего страшного, его еще просто НЕ добавляли
        result:=crtFnc('');
        SrcTree_insert_ChldFrst(item,result);
    end;
end;

