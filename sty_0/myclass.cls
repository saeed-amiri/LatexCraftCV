% myclass.cls
% First class
% A class:
%    Is loaded with \documentclass
%    Can load packages
%    Can redefine anything
%    Defines the identity of the document
% If the user provides data → command.
% If the user provides content → environment.

\AtBeginDocument{%
  \typeout{*** MYCLASS IS ACTIVE ***}
}
\NeedsTeXFormat{LaTeX2e}  % → this class works with that version
\ProvidesClass{myclass}[18/12/2025 Minimal example class]  % → Registers the class name and version

%Load the basic class
\LoadClass{article}  % → Inheritance

\RequirePackage{xcolor}
\RequirePackage{xparse}

% Define how title is printed
%Format: \renewcommand{cmd}{def}
\makeatletter
\renewcommand{\maketitle}{%
    \begin{center}
        {\LARGE\bfseries \@title \par}
        \vspace {4pt}
        {\large \@author \par}
        \vspace{2pt}
        {\small \@date \par}
    \end{center}
    \vspace{12pt}
}
\makeatother

% Line to with text
\ExplSyntaxOn
% \cvline[<color>]{<text>}
% If <text> is empty/blank -> full-width rule
% Else -> text + rule-fill to the end
\NewDocumentCommand{\cvline}{O{black} O{blue} m}
  {
    \par\noindent
    \group_begin:
      \tl_if_blank:nTF { #3 }
      {
        % no text -> full-width line
        \color{#1}\rule{\linewidth}{0.8pt}
      }
      {
        % text -> text then line to end
        \color{#2}#3\hspace{0.33em}%
        \color{#1}\leaders\hrule height 1.0pt\hfill\kern0pt
      }
    \vspace{1em}
    \group_end:
    \par
  }
\ExplSyntaxOff


% Header of the cv!
\ExplSyntaxOn
%\header[\author][title][author_color][rest_color][git][linkdin]{address}{email}{phone}
\NewDocumentCommand{\header}{O{Author} O{Email} O{Profession} O{Email} O{Adress} O{Git} O{LinkdIn} O{Phone}}
  {
   \par\noindent
   \group_begin:
    \tl_if_blank:nF { #1 } {\color{black}\textbf{#1}}
    \par
    \tl_if_blank:nF { #2 } { \color{black}Address:~#2\par }
    \tl_if_blank:nF { #3 } { \color{black}Profession:~#3\par }
    \tl_if_blank:nF { #4 } { \color{black}Email:~#4\par }
    \tl_if_blank:nF { #5 } { \color{black}Address:~#5\par }
    \tl_if_blank:nF { #6 } { \color{black}Git:~#6\par }
    \tl_if_blank:nF { #7 } { \color{black}LinkdIn:~#7\par }
    \tl_if_blank:nF { #8 } { \color{black}Phone:~#8\par }
   \group_end:
   \par
  }
\ExplSyntaxOff



% The header enviroment
%Format: \newenvironment{name}{begdef}{enddef}
\newenvironment{photoHead}[1][BLOCK]
{
  \par\noindent
  \textbf{#1}\par
  \hrule\par
  \vspace{0.3em}
}
{
  \par
}