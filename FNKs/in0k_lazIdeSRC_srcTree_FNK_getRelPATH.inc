//function SrcTree_getRelPATH(const item:tSrcTree_ROOT; const folder:string; const crtFnc:fSrcTree_crtRelPATH_callBACK):tSrcTree_fsFLDR;
var str:string;
    tmp:tSrcTree_item;
begin
    if path='' then result:=item // достигли КОРНЯ
    else begin
        result:=SrcTree_getRelPATH(item,srcTree_fsFnk_ExtractFileDir(path),crtFnc);
        if Assigned(result) then begin {todo: а иначе может быть????}
            // ищем СВОЕ имя среди его детей
            str   :=srcTree_fsFnk_ExtractFileName(path); //< имя, которое мы исчем
            tmp   :=result.ItemCHLD;
            while Assigned(tmp) do begin
                if (tmp is _tSrcTree_item_fsNodeFLDR_) and
                   (0=srcTree_fsFnk_CompareFilenames(str,_tSrcTree_item_fsNodeFLDR_(tmp).fsName))
                then begin
                    result:=_tSrcTree_item_fsNodeFLDR_(tmp);
                    BREAK;
                end;
                tmp:=tmp.ItemNEXT;
            end;
            //
            if not Assigned(tmp) then begin //< ненашли => создаем и ВСТАВЛЯЕМ
                tmp:=crtFnc(srcTree_fsFnk_ChompPathDelim(path));
                SrcTree_insert_ChldLast(result,tmp);
            end;
            result:=_tSrcTree_item_fsNodeFLDR_(tmp);
        end;
    end;
end;

{var lstDir:_tSrcTree_item_fsNodeFLDR_;
    mdlDir: string;
begin
    //--- прямой поиск, а вдруг оно уже есть
    result:=tSrcTree_fsFLDR(SrcTree_fndPathREL(item,folder,lstDir,mdlDir));
    //--- создаем промежуточный, если необходимо
    while (not Assigned(result))and(mdlDir<>'')and(srcTree_fsFnk_CompareFilenames(mdlDir,srcTree_fsFnk_ChompPathDelim(folder))<>0) do begin
        SrcTree_getRelPATH(item,mdlDir,crtFnc);
        {$ifdef _debug_}DEBUG('SrcTree_getRelPATH','add mdlDir',mdlDir);{$endIf}
        result:=tSrcTree_fsFLDR(SrcTree_fndPathREL(item,folder,lstDir,mdlDir));
    end;
    //--- создаем САМУ папку, если это досих пор необходимо
    if NOT Assigned(result) then begin
        {$ifOpt D+}Assert( Assigned(lstDir) ,'Wrong Find folder "'+folder+'"');{$endIf}
        // создаем НОВУЮ, , и  НОВУЮ
        result:=crtFnc(srcTree_fsFnk_ChompPathDelim(folder));//tSrcTree_fsFLDR.Create(ChompPathDelim(folder));
       //_move_All_Child_4fsNode_(lstDir,Result); //< перемещаем в неё все файловое
        SrcTree_insert_ChldLast(lstDir,Result); //< вставляем положенное место
        {$ifdef _debug_}DEBUG('SrcTree_getRelPATH','CRT folder',folder+' '+result.ItemTEXT+' '+result.ItemHINT);{$endIf}
    end;
end;}

