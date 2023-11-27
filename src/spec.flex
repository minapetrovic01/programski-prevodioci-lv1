// import sekcija

%%

// sekcija opcija i deklaracija
%class MPLexer
%function next_token
%line
%column
%debug
%type Yytoken

%eofval{
return new Yytoken( sym.EOF, null, yyline, yycolumn);
%eofval}

%{
//dodatni clanovi generisane klase
KWTable kwTable = new KWTable();
Yytoken getKW()
{
	return new Yytoken( kwTable.find( yytext() ),
	yytext(), yyline, yycolumn );
}
%}

//stanja
%xstate KOMENTAR
//makroi
slovo = [a-zA-Z]
cifra = [0-9]

%%

// pravila
\% { yybegin( KOMENTAR ); }
<KOMENTAR>~"%" { yybegin( YYINITIAL ); }

[\t\n\r ] { ; }

//operatori
\< { return new Yytoken( sym.LESS, yytext(), yyline, yycolumn ); }
\<= { return new Yytoken( sym.LESSEQ, yytext(), yyline, yycolumn ); }
\> { return new Yytoken( sym.GREATER, yytext(), yyline, yycolumn ); }
\>= { return new Yytoken( sym.GREATEREQ, yytext(), yyline, yycolumn ); }
\== { return new Yytoken( sym.EQ, yytext(), yyline, yycolumn ); }
\!= { return new Yytoken( sym.NOTEQ, yytext(), yyline, yycolumn ); }
\&\& { return new Yytoken( sym.AND, yytext(), yyline, yycolumn ); }
\|\| { return new Yytoken( sym.OR, yytext(), yyline, yycolumn ); }

//separatori
\( { return new Yytoken( sym.LEFTPAR, yytext(), yyline, yycolumn ); }
\) { return new Yytoken( sym.RIGHTPAR, yytext(), yyline, yycolumn ); }
\{ { return new Yytoken( sym.LEFTCURLY, yytext(), yyline, yycolumn ); }
\} { return new Yytoken( sym.RIGHTCURLY, yytext(), yyline, yycolumn ); }
; { return new Yytoken( sym.SEMICOLON, yytext(), yyline, yycolumn ); }
, { return new Yytoken( sym.COMMA, yytext(), yyline, yycolumn ); }
= { return new Yytoken( sym.ASSIGN, yytext(), yyline, yycolumn ); }


(true|false) { return new Yytoken( sym.CONST, yytext(), yyline, yycolumn ); }

//kljucne reci
{slovo}+ { return getKW(); }

//identifikatori
({slovo}|_)({slovo}|{cifra}|_)* { return new Yytoken(sym.ID, yytext(),yyline, yycolumn ); }

//konstante
0#o[0-7]+ { return new Yytoken( sym.CONST, yytext(), yyline, yycolumn ); }
0#x[0-9a-fA-F]+ { return new Yytoken( sym.CONST, yytext(), yyline, yycolumn ); }
(0#d)?{cifra}+ { return new Yytoken( sym.CONST, yytext(), yyline, yycolumn ); }
0.{cifra}+(E[+|-]?{cifra}+)? { return new Yytoken( sym.CONST, yytext(), yyline, yycolumn ); }
'[^]' { return new Yytoken( sym.CONST, yytext(), yyline, yycolumn ); }

//obrada gresaka
. { if (yytext() != null && yytext().length() > 0) System.out.println( "ERROR: " + yytext() ); }
