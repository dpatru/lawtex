%===============================================================================
% lawbrief.cls - Class file for a standard Appellate Court brief
% Copyright (C) 2009-2013  Christopher De Coro
%
% This file is part of the LaWTeX package, for more information, see:
%   Project Homepage: http://www.cs.princeton.edu/~cdecoro/lawtex/ 
%   Code Repository: https://sourceforge.net/projects/lawtex/
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.
%===============================================================================

%%\section{Law Brief Document Class}
%%The file lawbrief.cls provides a flexible document class for appellate-style legal briefs,
%%including cover page, table of contents, tables of authorities, etc.

\@ifundefined{SuppressClass}{%
\NeedsTeXFormat{LaTeX2e}
%\ProvidesClass{lawbrief}
\ProvidesClass{michiganCourtOfAppealsBrief}
\LoadClassWithOptions{article}
}{}%

\PassOptionsToClass{casesupra}{bluebook}
\RequirePackage[pdftex]{graphicx}
\RequirePackage{newcent}
\RequirePackage{array}
\RequirePackage{bluebook}
\RequirePackage[T1]{fontenc}
\RequirePackage{setspace}

%%%  ------------ from Document --------------------------
\RequirePackage{relsize}
\RequirePackage{etoolbox}
\RequirePackage[margin=1in]{geometry}
\RequirePackage{newcent,microtype}
\RequirePackage{setspace,xcolor}
\RequirePackage{trace}
\RequirePackage[T1]{fontenc}

% \RequirePackage[group-separator={,}]{siunitx} % comment out, probably not needed.

\RequirePackage{lipsum}

% From tex.stackexchange.com (https://tex.stackexchange.com/a/142258/135718)
\RequirePackage{xcolor}
\RequirePackage{todonotes}
% horizontal rule with text, https://tex.stackexchange.com/a/15122/135718
\newcommand*\ruleline[1]{%
  \par\noindent%
  \raisebox{.8ex}{\makebox[\linewidth]{\hrulefill\hspace{1ex}%
      \raisebox{-.8ex}{#1}%
      \hspace{1ex}\hrulefill}}}%

% https://www.overleaf.com/learn/latex/Environments
\newenvironment{draft}{%
  \color{blue}%
  \ruleline{Begin Draft}
}{%
  \ruleline{End Draft}
  \color{black}%
}
% 
% 

% \RequirePackage{xr-hyper}
\RequirePackage[hyperindex=false,linkbordercolor=white]{hyperref}
\RequirePackage{pdfpages}
%\RequirePackage{multirow}
%\RequirePackage{tabulary} % use ctable instead
\RequirePackage{ctable}
\RequirePackage{footmisc}% footnote references
\RequirePackage{needspace}
\RequirePackage[footnotes=multiple]{scrextend} % for footnotes in quotations https://tex.stackexchange.com/a/23612/135718

%%% -------------------------------------


% \RequirePackage{titlesec}


% \setcounter{secnumdepth}{4}
% \setcounter{tocdepth}{4}
% \setcounter{paragraph}{1}

% \titleformat{\paragraph}
% {\normalfont\normalsize\bfseries}{\theparagraph}{1em}{}
% \titlespacing*{\paragraph}
% {0pt}{3.25ex plus 1ex minus .2ex}{1.5ex plus .2ex}


\newcommand{\@RunMakeIndex}{%
  \message{At the end, running Index...\par}
  \immediate\closeout\Case@idxfile%
  \immediate\closeout\Statute@idxfile%
  \immediate\closeout\Other@idxfile%
  \write18{makeindex -r -s lawcitations.ist Case}%
  \write18{makeindex -L -r -s lawcitations.ist Statute}%
  \write18{makeindex -r -s lawcitations.ist Other}%
  \message{Ran make index\par}
}

\AtEndDocument{%
	\@RunMakeIndex%
}

%==============================================================================
%% \subsection{Sectioning}
%% We redefine formatting for section commands and the associated numbering. By default,
%% the top-level _\section_ (Question Presented, Statement of Facts, Argument, etc.) is unnumbered, bold and centered;
%% _\subsection_ is bold and left-aligned with a roman numeral; _\subsubsection_ is bold, left-indented, and with a letter
%% for ordering. (Note that the formatting in the table of contents differs somewhat, see below). By default, 
%% _\hyphenpenalty=10000_ is set so as to disable any hyphenation of words in each heading.
%==============================================================================

%Syntax for @startsection{name}{level}{indent}{abovespace}{belowspace}{format}
%The 4th argument is negative to suppress indenting after the section heading
% \def\section{\@startsection{section}{1}{0pt}{.5\baselineskip}{.5\baselineskip}{\centering\normalsize\bfseries}}%
% \def\subsection{\@startsection{subsection}{2}{0pt}{.5\baselineskip}{.5\baselineskip}{\hyphenpenalty=10000\normalsize\bfseries}}%
% \def\subsubsection{\@startsection{subsubsection}{3}{\parindent}{.5\baselineskip}{.5\baselineskip}{\hyphenpenalty=10000\bfseries}}%
% \renewcommand\cftsecaftersnum{.}
\def\section{\@startsection{section}{1}{0pt}{-.999\baselineskip}{0.001\baselineskip}{\singlespacing\centering\normalsize\bfseries}}%
\def\subsection{\@startsection{subsection}{2}{0pt}{-.999\baselineskip}{0.001\baselineskip}{\singlespacing\hyphenpenalty=10000\normalsize\bfseries}}%
% reduce the hyphenpenalty in hopes of encouraging line breaks
%\def\subsubsection{\@startsection{subsubsection}{3}{\parindent}{-.999\baselineskip}{0.001\baselineskip}{\singlespacing\hyphenpenalty=10000\bfseries}}%
\def\subsubsection{\@startsection{subsubsection}{3}{\parindent}{-.999\baselineskip}{0.001\baselineskip}{\singlespacing\hyphenpenalty=1\bfseries}}%


\newcounter{subsubsubsection}
% \makeatletter                 
\@addtoreset{subsubsubsection}{subsubsection}
\@addtoreset{subsubsubsection}{subsection}
\@addtoreset{subsubsubsection}{section}
% \makeatother
% \counterwithin{subsubsubsection}{subsubsection}
% \counterwithin{subsubsubsection}{subsection}
% \counterwithin{subsubsubsection}{section}
\setcounter{secnumdepth}{4}

\def\subsubsubsection{\@startsection{subsubsubsection}{4}{2\parindent}{-.999\baselineskip}{0.001\baselineskip}{\singlespacing\hyphenpenalty=1\bfseries}}%\let\subsubsubsection\@gobble}%

\DeclareRobustCommand{\@seccntformat}[1]{%https://tex.stackexchange.com/a/308739/135718
  \def\temp@@a{#1}%
  \def\temp@@b{section}%
  \ifx\temp@@a\temp@@b
  \csname the#1\endcsname\quad%
  \else
  \csname the#1\endcsname .\quad%
  \fi
} 
\newcommand\subsubsubsectionmark[1]{}

% \renewcommand{\@seccntformat}[1]{\csname the#1\endcsname\quad}
% \def\section{\@startsection{section}{1}{0pt}{-10pt}{2pt}{\centering\normalsize\bfseries}}%
% \def\subsection{\@startsection{subsection}{2}{0pt}{-2pt}{2pt}{\hyphenpenalty=10000\normalsize\bfseries}}%
% \def\subsubsection{\@startsection{subsubsection}{3}{\parindent}{-2pt}{2pt}{\hyphenpenalty=10000\bfseries}}%


%No numbers printed for section (remove \quad); I. Subsection; A. Subsubsection
\renewcommand{\thesection}{\hspace{-1em}}
% Add a section counter to fix includepdf error, See https://tex.stackexchange.com/questions/119719/add-an-item-in-the-table-of-contents and https://tex.stackexchange.com/questions/103706/includepdf-and-tableofcontents-without-numbering
%\newpage\addcontentsline{toc}{section}{Appendix}
\renewcommand\thesection{}
\addtocounter{section}{-1}

\renewcommand{\thesubsection}{\Roman{subsection}}
\renewcommand{\thesubsubsection}{\Alph{subsubsection}}
\renewcommand{\thesubsubsubsection}{\roman{subsubsubsection}}

%==============================================================================
%%
%% \subsection{Configuring the Index / Table of Authorities}
%% 
%==============================================================================

%%
%%_\indexindentsize_ --- Hanging indentation of toa from the left side (default: \the\indexindentsize)
%%
\newlength{\indexindentsize}			
\setlength{\indexindentsize}{18pt}

%%
%%\noindent _\indexrightmargin_ --- Right margin for all-but-the-last lines of toa (default: \the\indexrightmargin)
%% The current value will preserve .5 inch of space for non-final lines, and ragged margins. To change the spacing on
%% the last line between the entry and the page numbers, you must edit the style file.
\newlength{\indexrightmargin}	
\setlength{\indexrightmargin}{.5in plus 1.fil}

%%
%%\noindent _\passimlimit_ --- Use ``passim'' above this many pages (default: \passimlimit).  
%% Can be changed with \\ _\renewcommand{\passimlimit}{5}_, etc. 
%% Make sure to set this before the index is created (i.e. in the header).
%%
\newcommand{\passimlimit}{5}

%\pagenumber is the command to format page numbers in index rows
%  Each invocation adds the number to @assembledpagenums; incr. @passimcount
%  \@printpagenums called at end of each row, dumps values
\def\@pagenums{}
\newcounter{@passimcount}

\newcommand{\pagenumber}[1]{%
	\addtocounter{@passimcount}{1}%
	\ifnum\value{@passimcount}=1%
        \edef\@pagenums{#1}%
        \edef\@firstpage{#1}%
	\else% 
		\ifnum\value{@passimcount}<\passimlimit%
			\edef\@pagenums{\@pagenums, #1}%
		\else
			\def\@pagenums{\@firstpage, \emph{passim}}%
		\fi%
	\fi%
	\IfSubStr{#1}{passim}{\setcounter{@passimcount}{\passimlimit}\def\@pagenums{\emph{passim}}}{}%
}

\newcommand{\@printpagenums}{%
	\@pagenums%
	\def\@pagenums{}%
	\setcounter{@passimcount}{0}%
}

%%
%%\noindent _\idxpassim_ --- Used in an index command, forces passim to always be used for a particular cite
%%
\newcommand{\idxpassim}[1]{passim}

\renewenvironment{theindex}
               {\parindent=\indexindentsize%
                % \parskip=10pt plus .3pt%
                \linepenalty=1000%
                \hyphenpenalty=10000%
                \rightskip=\indexrightmargin%
                \parfillskip=-\indexrightmargin%
                \setcounter{@passimcount}{0}%
                \let\item\@idxitem
                \let\subitem\@idxsubitem}
               {\@printpagenums\par}

\renewcommand\@idxitem{\@printpagenums \par \hangindent 2\indexindentsize}
\providecommand\@idxsubitem{\@idxitem \hspace*{20pt}}

%\renewcommand\indexspace{\par \vskip 10pt plus 5pt minus 3pt \relax}

%%\noindent
%%_\caseindextitle_ --- Set the title for the case section of the table of authorities (Default: \@caseindextitle).
%%
%%\noindent
%%_\statutesindextitle_ --- Set the title for the statutes section of the table of authorities (Default: \@statutesindextitle).
%%
%%\noindent
%%_\otherindextitle_ --- Set the title for the miscellaneous section of the table of authorities (Default: \@otherindextitle).
%%
\def\@caseindextitle{Cases}
\newcommand{\caseindextitle}[1]{\def\@caseindextitle{#1}}

\def\@statutesindextitle{Constitutional Provisions, Statutes and Rules}
\newcommand{\statutesindextitle}[1]{\def\@statutesindextitle{#1}}

\def\@otherindextitle{Other Authorities}
\newcommand{\otherindextitle}[1]{\def\@otherindextitle{#1}}

%Generates files for each type of index entry
\makeindex{Case}
\makeindex{Statute}
\makeindex{Other}

%%
%% \noindent _\tableofauthorities_ --- Print the table of authorities.
%%
\newcommand{\tableofauthorities}{%
{%
\singlespacing
\section{Table of Authorities} \pagestyle{toa}\thispagestyle{romanparen}%
	\iffileexists{Case.ind}{%
	\noindent\sc \@caseindextitle\hfill\rm Page\par
	% \vspace{6pt}
	\everypar={\mark{\@caseindextitle---Continued}}
	\printindex{Case}
        }{}
%
	\iffileexists{Statute.ind}{%
		\everypar={\mark{\@statutesindextitle---Continued}}
		~\par\noindent\sc \@statutesindextitle\hfill\rm\par
		\printindex{Statute}
		~\par
	}{}
%
	\iffileexists{Other.ind}{%
		\everypar={\mark{\@otherindextitle---Continued}}
		\noindent\sc \@otherindextitle\rm\par
		\printindex{Other}
	}{}
	\newpage
}}

%==============================================================================
%%
%% \subsection{Table-of-Contents commands}
%%
%==============================================================================

%%
%%_\tableofcontents_ --- Print the table of contents.
%%
% \renewcommand\tableofcontents{{\setlength{\parskip}{2ex plus 1ex minus .5ex} \@starttoc{toc}}}
\renewcommand\tableofcontents{\@starttoc{toc}}

\def\@snumwidth{2em}		%Size of box around toc section number
\def\@ssnumwidth{4em}		%Size of box around toc section number
\def\@pnumwidth{2em}		%Size of right margin in toc for all but last line
\def\@smallpnumwidth{1em}	%Size of box put around toc pagenumber

%%
%%\noindent _\@tocline_ --- Sets the leaders to print aligned dots. Redefine to change.
%%
\newcommand{\@tocline}[2]{#1\nobreak \leaders \hbox to 0.125in{\hfil.\hfil} \hfill \nobreak\hb@xt@\@smallpnumwidth{\hss #2}\par}

%%
%%\noindent _\l@section_ --- Formats Top-level headings in the ToC flush left and small caps
%%
\renewcommand*\l@section[2]{%
    \addpenalty\@secpenalty%		Prefer to break before or after the tocline, not during
    \setlength\@tempdima{0em}%		Size of the space reserved for section number (which isn't there, so 0)
	{
      \parindent=0pt%				Dont automatically indent
	  \@tocline{{#1}}{#2}
	}
}

%%
%%\noindent _\l@subsection_ --- Formats Second-level headings indented from left with a hanging indent of _\@pnumwidth_
%%
\renewcommand*\l@subsection[2]{%
    \addpenalty\@secpenalty%		Prefer to break before or after the tocline, not during
    \@tempdima=\@snumwidth%         Size of the space reserved for the subsection number
	{
      \parindent=0pt%				Don't indent number; secname implicitly indented to \@tempdima
	  \rightskip=\@pnumwidth
      \parfillskip=-\@pnumwidth
      \leavevmode 
      \advance\leftskip\@tempdima
      \hskip -\leftskip
	  \@tocline{#1}{#2}
	}
}

%%
%%\noindent _\l@subsubsection_ --- Formats Third-level headings indented more from left with a hanging indent of _\@pnumwidth_
%%
\renewcommand*\l@subsubsection[2]{%
    \addpenalty\@secpenalty%		Prefer to break before or after the tocline, not during
    \@tempdima=\@snumwidth%         Size of the space reserved for the subsubsection letter
	{
      \parindent=\@snumwidth%		Indent first line equal to the previous subsection's letter indent
	  \rightskip=\@pnumwidth%		Reserve a larger-than-usual right margin
      \parfillskip=-\@pnumwidth%	And then compensate the last line, so that it is full width
      \leavevmode
      \advance\leftskip2\@tempdima% This is an odd trick that basically does the same as a \hangindent,
      \hskip -\leftskip%			but has the effect of keeping the leaders aligned
	  \@tocline{#1}{#2}
	}
}

%%\noindent _\l@subsubsection_ --- Formats Third-level headings indented more from left with a hanging indent of _\@pnumwidth_
%%
\newcommand*\l@subsubsubsection[2]{%
    \addpenalty\@secpenalty%		Prefer to break before or after the tocline, not during
    \@tempdima=\@snumwidth%         Size of the space reserved for the subsubsection letter
	{
      \parindent=\@ssnumwidth%		Indent first line equal to the previous subsection's letter indent
	  \rightskip=\@pnumwidth%		Reserve a larger-than-usual right margin
      \parfillskip=-\@pnumwidth%	And then compensate the last line, so that it is full width
      \leavevmode
      \advance\leftskip2\@tempdima% This is an odd trick that basically does the same as a \hangindent,
      \hskip -\leftskip%			but has the effect of keeping the leaders aligned
	  \@tocline{#1}{#2}
	}
}

%==============================================================================
%%
%% \subsection{Page numbering commands}
%%
%% These commands are used by calling _\pagestyle{romanparen}_, _\thispagestyle{toa}_, etc.
%%
%==============================================================================

%%
%% \noindent Pagestyle _romanparen_ --- roman numerals inside parenthesis at bottom
%%
\newcommand{\ps@romanparen}{%
	\def\thepage{\roman{page}}
	\def\@oddhead{}%
	\def\@evenhead{}%
	\def\@oddfoot{\hfill(\roman{page})\hfill}%
	\def\@evenfoot{\hfill(\roman{page})\hfill}%
}

%%
%% \noindent Pagestyle _toa_ --- ``inherits'' from romanparen, but also puts the current mark at the top
%%
\newcommand{\ps@toa}{%
	\ps@romanparen%
	\def\@oddhead{\ifthenelse{\equal{\topmark}{\firstmark}}{\lower1em\hbox to \textwidth{{\sc\topmark} \hfill Page}}{\lower3em\hbox to \textwidth{\hfill Page}}}%
	\def\@evenhead{\ifthenelse{\equal{\topmark}{\firstmark}}{{\sc\topmark} \hfill Page}{\lower5em{\hfill Page}}}%
}

%%
%% \noindent Pagestyle _footertext_ --- Sets the argument to _\footertext_ in the footer, flush left
%%
\newcommand{\footertext}[1]{\def\@footertext{#1}}

\newcommand{\ps@footertext}{%
	\def\thepage{\roman{page}}
	\def\@oddhead{}%
	\def\@evenhead{}%
	\def\@oddfoot{\@footertext\hfill\def\@footertext{}}%
	\def\@evenfoot{\@footertext\hfill}%
}

%==============================================================================
%% \subsection{Title Page commands}
%%
%% \noindent _\firstparty_, _\secondparty_ --- Sets the name of the first and second parties in the title page or caption.
%%
%% \noindent _\firstpartytitle_, _\secondpartytitle_ --- Set the title (Plaintiff, Defendants, etc.) of the parties.
%%
%% \noindent _\plaintiff_, _\defendant_, _\appellant_, _\appellee_, _\petitioner_, _\respondant_ --- Set both the name and title of each party. 
%% Note that each of these also has a plural version (e.g., _\plaintiffs_).
%%
%% \noindent _\titlegraphic_ --- Set the stylized header for the title page.
%%
%% \noindent _\maketitle_ 
%%
%% This creates the title page, and generally would be called immediately
%% after the _\begin{document}_. Alternatively, you may call _\makefrontmatter_, which 
%% will create the title, question presented (which per Supreme Court rules is on the page 
%% immediately after the title), table of contents, and table of authorities.
%%
%% For additional changes, such as an overall formatting change, I suggest that 
%% it would be easiest for you to modify the macro _\maketitle_ or _\makefrontmatter_ 
%% in the class file directly.
%%
%% \noindent _\makecaption_ --- Creates a trial-brief style caption, as opposed to a cover page.
%%
%==============================================================================

\newcommand{\sectionline}{\vbox{\baselineskip=1.5pt \hbox{\rule{\linewidth}{.7pt}}\hbox{\rule{\linewidth}{.7pt}}}}
\newcommand{\smallrule}{\rule{.3\linewidth}{.7pt}}

\newcommand{\firstparty}[1]{\def\@firstparty{#1}}
\newcommand{\firstpartytitle}[1]{\def\@firstpartytitle{#1}}

% Calling the following macros (plaintiff, appellant, ...) sets the
% first and second party automatically.
\newcommand{\plaintiff}[1]{\firstparty{#1}\firstpartytitle{Plaintiff}}
\newcommand{\plaintiffs}[1]{\firstparty{#1}\firstpartytitle{Plaintiffs}}
\newcommand{\appellant}[1]{\firstparty{#1}\firstpartytitle{Appellant}}
\newcommand{\appellants}[1]{\firstparty{#1}\firstpartytitle{Appellants}}
\newcommand{\petitioner}[1]{\firstparty{#1}\firstpartytitle{Petitioner}}
\newcommand{\petitioners}[1]{\firstparty{#1}\firstpartytitle{Petitioners}}

\newcommand{\secondparty}[1]{\def\@secondparty{#1}}
\newcommand{\secondpartytitle}[1]{\def\@secondpartytitle{#1}}
\newcommand{\defendant}[1]{\secondparty{#1}\secondpartytitle{Defendant}}
\newcommand{\defendants}[1]{\secondparty{#1}\secondpartytitle{Defendants}}
\newcommand{\appellee}[1]{\secondparty{#1}\secondpartytitle{Appellee}}
\newcommand{\appellees}[1]{\secondparty{#1}\secondpartytitle{Appellees}}
\newcommand{\respondent}[1]{\secondparty{#1}\secondpartytitle{Respondent}}
\newcommand{\respondents}[1]{\secondparty{#1}\secondpartytitle{Respondents}}

\newcommand*{\actionnumber}[1]{\def\@actionnumber{#1}}
\newcommand*{\supervisor}[1]{\def\@supervisor{#1}}
\newcommand*{\email}[1]{\def\@email{#1}}
\newcommand*{\docket}[1]{\def\@docket{#1}}
\newcommand*{\circuit}[1]{\def\@circuit{#1}}
\newcommand{\court}[1]{\def\@court{#1}}
\newcommand*{\brieffor}[1]{\def\@brieffor{#1}}
\newcommand{\address}[1]{\def\@address{#1}}
\newcommand*{\titlegraphic}[1]{\def\@titlegraphic{#1}}

\def\@firstparty{\@latex@warning@no@line{No \noexpand\firstparty given}}
\def\@firstpartytitle{Plaintiff}
\def\@secondparty{\@latex@warning@no@line{No \noexpand\secondparty given}}
\def\@secondpartytitle{Defendant}
\def\@actionnumber{\@latex@warning@no@line{No \noexpand\actionnumber given}}
\def\@supervisor{\@latex@warning@no@line{No \noexpand\supervisor given}}
\def\@email{\@latex@warning@no@line{No \noexpand\email given}}
\def\@docket{\@latex@warning@no@line{No \noexpand\docket given}}
\def\@circuit{\@latex@warning@no@line{No \noexpand\circuit given}}
\def\@court{\@latex@warning@no@line{No \noexpand\court given}}
\def\@brieffor{\@latex@warning@no@line{No \noexpand\brieffor given}}
\def\@address{\@latex@warning{No \noexpand\address given}}
\def\@titlegraphic{SupremeCourt.pdf}

\newcommand{\questionpresented}[1]{\def\@questionpresented{#1}}

\renewcommand{\maketitle}{}
% \renewcommand{\maketitle}{\makesupremetitle}



\newcommand{\makecaption}[1]{{
\singlespacing

\begin{centering}
\bf\scshape \@court \\~\\ 
\rm 


\begin{tabular}{p{.45\textwidth}|p{.45\textwidth}}
\cline{1-1}
{~

\raggedright\@firstparty, 

\hfill\textit{\@firstpartytitle,}

\centerline{v}

\raggedright\@secondparty, 

\hfill\textit{\@secondpartytitle.} 

~
} &
{ \begin{flushright} \textbf{#1}  \end{flushright}
} \\
\cline{1-1}
\end{tabular}

\end{centering}
}}

%%
%% \noindent _\makefrontmatter_
%%
%% Creates all the boilerplate front matter, including the title page (by calling _\maketitle_), 
%% the question presented (taken from the argument of _\questionpresented_), the table of contents and 
%% the table of authorities (by calling _\tableofcontents_ and _\tableofauthorities_, respectively).
%%
\newcommand{\makefrontmatter}[1]{
%\maketitle
\makecaption{#1}

\pagestyle{romanparen}
\pagenumbering{roman}
%% \newpage

\section*{Table of Contents}
\tableofcontents
%% \newpage
\tableofauthorities

\pagestyle{plain}
\pagenumbering{arabic}
}

%%
%% \noindent _\rightbox_ environment
%%
%% The contents of this environment will themselves be left-aligned, but the entire box 
%% containing them will be as far to the right as possible. This is useful for signature-type
%% boxes at the end of the brief.
%%
\newenvironment{rightbox}{
	%Start a new group to contain the def of the testbox and newline
	\bgroup
	%Store the box here
	\newbox\testbox
	%Change newline so that each line is an hbox
	\def\\{\unskip\egroup\hbox\bgroup\ignorespaces}
	%Start vbox{hbox{ ...
	\setbox\testbox=\vbox\bgroup\hbox\bgroup\ignorespaces}
	%End the last hbox and the vbox
	{\unskip\egroup\egroup
	%Output a fill, then the box
	\hskip 0pt plus 1.0fill \box\testbox \egroup }

%==============================================================================
% Misc Default Settings
%==============================================================================

%Set the first pagestyle to have no number
\thispagestyle{empty}

\clubpenalty=3000
\widowpenalty=3000

\RequirePackage[shortlabels]{enumitem}% remove extra spaces in itemize and enumerate, see http://mirror.utexas.edu/ctan/macros/latex/contrib/enumitem/enumitem.pdf
\setlist[enumerate]{nosep}
\setlist[itemize]{nosep}
\setlist[description]{nosep}
\deffootnote[1.8em]{0em}{1em}{\textsuperscript{\thefootnotemark}}%%\parindent 1em\noindent \hb@xt@ 1.8em{\hss \textsuperscript{\thefootnotemark}}}%\parindent 1em\noindent \hb@xt@ 1.8em{\hss \@makefnmark }
\providecommand\qfootnote[1]{{\deffootnotemark{\textsuperscript{\thefootnotemark}}\footnote{#1}}}%
\renewenvironment{quote}%
{\begin{singlespacing}%\smaller
    % \renewcommand{\thefootnote}{[\arabic{footnote}]}
    % See https://tex.stackexchange.com/a/23612/135718
    \deffootnotemark{\textsuperscript{[\thefootnotemark]}}%
    \list{}{\rightmargin=\leftmargin\topsep=0pt\itemsep=0pt\parsep=0em}\item\relax}%
{\endlist\end{singlespacing}}
%\AtBeginEnvironment{quote}{\singlespacing}%\small}

\renewenvironment{quotation}%
%{\begin{singlespacing}\list{}{\rightmargin=\leftmargin\topsep=0pt}\item\relax}%
{\begin{singlespacing}%\smaller
    \deffootnotemark{\textsuperscript{[\thefootnotemark]}}%
    \list{}{\rightmargin=\leftmargin\parsep=.7em%\topsep=0pt\itemsep=0pt\parsep=0em%
    }\item\relax}%
{\endlist\end{singlespacing}}


% vim: set syntax=tex :
