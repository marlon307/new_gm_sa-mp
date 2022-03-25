//carregamento
CMD:sav(playerid,params[])
{
    new p;
    new str[100],Float:X,Float:Y,Float:Z,Float:R;
    GetPlayerPos(playerid, X, Y, Z);
    GetPlayerFacingAngle(playerid, R);

    new File:pos = fopen("positions.txt", io_append);

    if(sscanf(params,"i",p))return SendClientMessage(playerid,-1,"[Digite o numero sucessor]");
    {
        format(str, 100, "%d,%f,%f,%f,%f;\r\n",p,X,Y,Z,R);
        fwrite(pos, str);
    }
    fclose(pos);
    return 1;
}
new iddd,Float:_lpX[10],Float:_lpY[10],Float:_lpZ[10],Float:_lpR[10];

_CallBack: LoadStaticPositions(const filename[])
{
	new File:file_ptr;
	new line[200];
	new var_from_line[70];
	new index;

	file_ptr = fopen(filename,filemode:io_read);
	if(!file_ptr) return 0;

    while(fread(file_ptr,line,200) > 0)
    {
        index = 0;

        index = token_by_delim(line,var_from_line,',',index);
        if(index == (-1)) continue;
  		iddd = strval(var_from_line);

        index = token_by_delim(line,var_from_line,',',index+1);
        if(index == (-1)) continue;
  		_lpX[iddd] = floatstr(var_from_line);

        index = token_by_delim(line,var_from_line,',',index+1);
        if(index == (-1)) continue;
  		_lpY[iddd] = floatstr(var_from_line);

        index = token_by_delim(line,var_from_line,',',index+1);
        if(index == (-1)) continue;
  		_lpZ[iddd] = floatstr(var_from_line);

        index = token_by_delim(line,var_from_line,';',index+1);
        if(index == (-1)) continue;
  		_lpR[iddd] = floatstr(var_from_line);
	}
	fclose(file_ptr);
	return 1;
}

stock token_by_delim(const string[], return_str[], delim, start_index)
{
	new x=0;
	while(string[start_index] != EOS && string[start_index] != delim)
    {
	    return_str[x] = string[start_index];
	    x++;
	    start_index++;
	}
	return_str[x] = EOS;
	if(string[start_index] == EOS) start_index = (-1);
	return start_index;
}
