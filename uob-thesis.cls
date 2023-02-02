\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uob-thesis}[2023/02/02 University of Bristol thesis template]

%% BUILT ACCORDING TO THE PGR CODE:
%%
%%    http://www.bristol.ac.uk/academic-quality/pg/pgrcode/annex4/
%%

\RequirePackage{xkeyval}

%% KOMA stuff

\PassOptionsToClass{
  a4paper,
  fontsize=11pt,
  twoside,
  listof=totoc,
  listof=chapterentry,
}{scrbook}

%% Forward other options to KOMA
\DeclareOptionX*{%
  \PassOptionsToClass{\CurrentOption}{scrbook}
}
\ProcessOptionsX*\relax

\usepackage{mlmodern}

%% LOAD KOMA CLASS

\LoadClass{scrbook}

%% Load useful packages

\RequirePackage{bristol-colours}
\RequirePackage{xparse}
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

%% Font options

\usepackage[T1]{fontenc}
\renewcommand{\bfdefault}{b}
\usepackage{microtype}

\setkomafont{disposition}{\bfseries}
\addtokomafont{title}{\Huge}
\linespread{1.5} % some extra spacing

%% Bibliography options 

\RequirePackage[
  backend=biber,
  doi=true,
  backref=true,
  sortcites=true,
  style=acmauthoryear,
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
      % \step[fieldset=eprint, null] % remove this to print arXiv numbers
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


%% PAGE STYLES

\usepackage[automark]{scrlayer-scrpage}
\renewcommand*{\partpagestyle}{empty}
\pagestyle{scrheadings}
\cfoot*{\pagemark}
\ofoot[]{}
\ifoot[]{}

%% TITLE PAGE

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
\titlehead{\thispagestyle{titlepage}}

\publishers{
  \bigskip\bigskip\bigskip
  \includegraphics[width=0.5\textwidth]{bristol-logo.png} \\[2em]
  A dissertation submitted to the University of Bristol in accordance with the requirements for award of the degree of {\the\@degree} in the {\the\@faculty}. \\[2em]
  \the\@school \\
  \the\@date \\
}

\NewDocumentEnvironment{abstract}{+b}{%
  \thispagestyle{empty}
  \begin{center}
    {\Large\bfseries Abstract}\\
    \medskip\medskip
  \end{center}
  \quotation
  {#1}
  \endquotation
  \cleardoublepage
}{}

\RenewDocumentEnvironment{dedication}{+b}{
  \thispagestyle{empty}
  \begin{center}
    \Large\itshape {#1}
  \end{center}
  \cleardoublepage
}{}

\NewDocumentEnvironment{acknowledgements}{+b}{
  \thispagestyle{empty}
  \begin{center}
    \Large\bfseries Acknowledgements
  \end{center}
  {#1}
  \cleardoublepage
}{}

\NewDocumentEnvironment{declaration}{+b}{
  \thispagestyle{empty}
  \thispagestyle{empty}
  \begin{center}
    \Large\bfseries Author's Declaration
  \end{center}
  \quotation
  {#1} 
  \endquotation
  \vspace{6em}
  \@author
  \cleardoublepage
}{}
