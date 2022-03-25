/**
 * Retorna um numero por extenso
 *
 * @param      value  Valor
 *
 * @example
 *                 print(PorExtenso(999_999_999)); //Output: novecentos e noventa e nove milhões, novecentos e noventa e nove mil, novecentos e noventa e nove
 *
 * @autor        Dayvison
 * @date        04-10-2016
 * @return        Valor escrito por extenso
 */
PorExtenso(value)
{
    // Certificar que o valor esteja na casa dos milhões
    assert(value <= 999_999_999);
    static unidade[20][10] = { "","um","dois","três","quatro", "cinco","seis", "sete", "oito", "nove", "dez", "onze", "doze", "treze","quatorze","quinze","dezesseis","dezessete","dezoito","dezenove"};
    static dezena[10][10] = { "","","vinte","trinta","quarenta", "cincoenta","sessenta", "setenta", "oitenta", "noventa"};
    static centena[10][13] = {"cem", "cento", "duzentos", "trezentos" , "quatrocentos", "quinhentos", "seiscentos","setecentos","oitocentos","novecentos"};

    new _@buffer[128];
    new _@Milhao = value/1000000;
    new _@Milhar = value%1000000/1000;
    new _@Centena = value%1000000%1000/100;
    new _@Dezena = value%1000000%1000%100/10;
    new _@Unidade = value%1000000%1000%100%10;
    if(_@Milhao)
    {
        static cTeste[56];
        strcat(cTeste, PorExtenso(_@Milhao));
        strcat(_@buffer, cTeste);
        if(_@Milhao == 1)
            strcat(_@buffer, " milhão, ");
        else

            strcat(_@buffer, " milhões, ");
    }
    if(_@Milhar)
    {
        static cTeste[56];
        strcat(cTeste, PorExtenso(_@Milhar));

        strcat(_@buffer, cTeste);
        strcat(_@buffer, " mil");
    }
    if(_@Centena)
    {
        if(_@Centena == 1 && _@Dezena == 0 && _@Unidade == 0)
        {
            if(_@Milhar) strcat(_@buffer, " e ");
            strcat(_@buffer, "cem");
        }
        else
        {
            if(_@Milhar) strcat(_@buffer, ", ");
            strcat(_@buffer, centena[_@Centena]);
        }
    }
    if(_@Dezena)
    {
        if(_@Centena || _@Milhar) strcat(_@buffer, " e ");
        if(_@Dezena < 2)
        {
            strcat(_@buffer, unidade[_@Dezena*10+_@Unidade]);
            return _@buffer;
        }
        else strcat(_@buffer, dezena[_@Dezena]);
    }
    if(_@Unidade)
    {
        if(_@Centena || _@Milhar || _@Dezena) strcat(_@buffer, " e ");
        strcat(_@buffer, unidade[_@Unidade]);
    }
    return _@buffer;
}
