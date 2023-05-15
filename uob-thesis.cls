\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uob-thesis}[2023/05/15 University of Bristol thesis template]
%% Prepared by Alex Kavvos in 2023.
%%
%% BUILT ACCORDING TO THE PGT AND PGR CODE:
%%
%%  http://www.bristol.ac.uk/academic-quality/pg/pgrcode/annex4/
%%  http://www.bristol.ac.uk/media-library/sites/academic-quality/documents/taught-code/annexes/dissertations.pdf
%%

\RequirePackage{xkeyval}
\RequirePackage{xparse}

%% variable holding whether entire document should be one- or two-sided
\newtoks\@uobtwoside
\@uobtwoside={semi}
\newtoks\@uobbiblio

%% variable holding style of bibliography
\@uobbiblio={acmauthoryear}

%% KOMA stuff

\PassOptionsToClass{
  a4paper,
  twoside={\the\@uobtwoside},
  fontsize=11pt,
  listof=totoc,
  listof=chapterentry,
  titlepage=firstiscover,
}{scrbook}

\DeclareOptionX{twoside}{\@uobtwoside={true}}
\DeclareOptionX{ieee}{\@uobbiblio={ieee}}
\DeclareOptionX{acmnumeric}{\@uobbiblio={acmnumeric}}

%% Forward other options to KOMA
\DeclareOptionX*{%
  \PassOptionsToClass{\CurrentOption}{scrbook}
}
\ProcessOptionsX*\relax

\usepackage{mlmodern}

%% LOAD KOMA CLASS

\LoadClass{scrbook}
\RequirePackage{scrlayer-scrpage}

%% Font options

\usepackage[T1]{fontenc}
\usepackage{microtype}

\setkomafont{disposition}{\bfseries}
\addtokomafont{title}{\Huge}
\linespread{1.5} % some extra spacing


%% Set page style and recalculate type area

\KOMAoptions{headinclude=true, DIV=10}

\renewcommand*{\partpagestyle}{empty}
\pagestyle{scrheadings}
\cfoot*{\pagemark}
\ofoot[]{}
\ifoot[]{}

\recalctypearea



%% Load useful packages

\RequirePackage[british]{datetime2}
\DTMlangsetup[en-GB]{ord=omit}

\RequirePackage{bristol-colours}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{wasysym}
\RequirePackage{stmaryrd}
\RequirePackage{fontawesome}
\RequirePackage{mleftright}
\RequirePackage{ifthen}
\RequirePackage{scalerel}
\RequirePackage{epigraph}
\RequirePackage{datetime}
\RequirePackage{enumitem}
\RequirePackage{array}
\RequirePackage{mathtools}
\RequirePackage{etoolbox}
\RequirePackage{thmtools}

%% Macro for re-setting whether one- or two-sided

% \NewDocumentCommand{\settwoside}{o}{
%   \IfValueTF{#1}{
%     \KOMAoptions{twoside={#1}}
%   }{
%     \KOMAoptions{twoside={\the\@uobtwoside}}
%   }
%   \recalctypearea
% }


%% Bibliography options 

\RequirePackage[
  backend=biber,
  doi=true,
  backref=true,
  sortcites=true,
  style={\the\@uobbiblio},
  maxnames=1000,
  mincrossrefs=99,
  sorting=nyt,
  sortcites
]{biblatex}

% this is necessary to use ACM references in a non-ACM class
\newcommand{\bibliofont}{\normalsize}
\renewcommand*{\bibfont}{\bibliofont}

%% remove from bibtex: isbn, address, location, month
\DeclareSourcemap{
  \maps[datatype=bibtex, overwrite]{
    \map{
      % \step[fieldset=isbn, null]
      % \step[fieldset=address, null]
      % \step[fieldset=location, null]
      \step[fieldset=month, null]
      % \step[fieldset=eprint, null]    % comment this to erase arXiv idents
    }
  }
}

%% checks if doi is non-null; if yes, clear URL
\DeclareSourcemap{
  \maps[datatype=bibtex]{
     \map{
        \step[fieldsource=doi,final]
        \step[fieldset=url,null]
        }
      }
}

%% Hyperref 

\usepackage[pdfusetitle,hyperfootnotes=false]{hyperref}
\usepackage{hyperref}
\usepackage[capitalize,nameinlink]{cleveref}
\hypersetup{breaklinks=true,colorlinks=true,linkcolor=UniversityRed,urlcolor=UniversityRed, citecolor=UniversityRed}


%% TITLE PAGE

\NewDocumentCommand{\printdatewithoutmonth}{m}{
  \DTMdefboolkey{en-GB}{showdayofmonth}[false]{} 
  \DTMusedate{#1}
  \DTMdefboolkey{en-GB}{showdayofmonth}[true]{} 
}


\newtoks\@degree
\NewDocumentCommand{\degree}{m}{\@degree={#1}}

\newtoks\@school
\NewDocumentCommand{\school}{m}{\@school={#1}}

\newtoks\@faculty
\NewDocumentCommand{\faculty}{m}{\@faculty={#1}}

\newtoks\@date
\RenewDocumentCommand{\date}{m}{\@date={#1}}

\newtoks\@wordcount
\NewDocumentCommand{\wordcount}{m}{\@wordcount={#1}}

\defpairofpagestyles[plain.scrheadings]{titlepage}{
  \cfoot[]{}
  \ofoot*{\normalfont Word count: \the\@wordcount}
}
% \renewcommand*{\titlepagestyle}{titlepage}
\titlehead{\thispagestyle{titlepage} \recalctypearea}

\publishers{
  \bigskip\bigskip\bigskip
  \includegraphics[width=0.5\textwidth]{bristol-logo.png} \\[2em]
  A dissertation submitted to the University of Bristol in accordance with the requirements for award of the degree of {\the\@degree} in the {\the\@faculty}. \\[2em]
  \the\@school \\
  \the\@date \\
}

\NewDocumentEnvironment{abstract}{+b}{%
  \recalctypearea
  \thispagestyle{empty}
  \begin{center}
    {\Large\bfseries Abstract}\\
  \end{center}
  \bigskip
  {#1}
  \cleardoubleoddemptypage
}{}

\RenewDocumentEnvironment{dedication}{+b}{
  \thispagestyle{empty}
  \begin{center}
    \Large\itshape {#1}
  \end{center}
  \cleardoubleoddemptypage
}{}

\NewDocumentEnvironment{acknowledgements}{+b}{
  \thispagestyle{empty}
  \begin{center}
    \Large\bfseries Acknowledgements
  \end{center}
  \bigskip
  {#1}
  \cleardoubleoddemptypage
}{}

\NewDocumentEnvironment{declaration}{+b}{
  \thispagestyle{empty}
  \thispagestyle{empty}
  \begin{center}
    \Large\bfseries Author's Declaration
  \end{center}
  \bigskip
  \quotation
  {#1} 
  \endquotation
  \@author \\
  \DTMusedate{thesisdate}
  \cleardoubleoddpage
}{}
