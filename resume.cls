\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2024/09/22 An elegant Résumé class]
\newcommand{\resumestyle}{classic}
\LoadClass[11pt]{article}

% disable indent globally
\setlength{\parindent}{0pt}
% some general improvements, defines the XeTeX logo
\RequirePackage{xltxtra}
% use ifthen
\RequirePackage{ifthen}
\RequirePackage{xparse}
\newcommand{\isempty}[1]{\equal{#1}{}}
% use hyperlink for email and url
\RequirePackage{hyperref}
\hypersetup{hidelinks}
\RequirePackage{url}
\urlstyle{tt}

% use fontawesome6
\RequirePackage{stys/fontawesome6}

% use xcolor for customizing color
\RequirePackage{xcolor}
%% Color setup
\definecolor{cyanbg}{HTML}{f0fafa}
\definecolor{cyanfg}{HTML}{00a6a7}
\definecolor{nwpubluebg}{HTML}{01408f}
% \definecolor{nwpubluebg}{HTML}{004DFF} % C100 M70
\definecolor{resumeblack}{HTML}{000000}
\definecolor{simplev2red}{HTML}{9F1D2F}

% loading fonts
\RequirePackage{fontspec}
% Main document font
\setmainfont[
  Path = fonts/Main/ ,
  Extension = .otf ,
  UprightFont = *-regular ,
  BoldFont = *-bold ,
  ItalicFont = *-italic ,
  BoldItalicFont = *-bolditalic ,
  SmallCapsFont = Fontin-SmallCaps
]{texgyretermes}

\RequirePackage[
	a4paper,
	left=0.80in,
	right=0.80in,
	top=0.85in, % tune this!
	bottom=0.55in,
	nohead
]{geometry}

\RequirePackage{titlesec}
\RequirePackage{enumitem}
\setlist{noitemsep} % removes spacing from items but leaves space around the whole list
%\setlist{nosep} % removes all vertical spacing within and around the list
\setlist[itemize]{topsep=0.25em, leftmargin=1.25pc}
\setlist[enumerate]{topsep=0.25em, leftmargin=1.25pc}
\RequirePackage[super]{nth}

\newcommand{\titlelinestyle}{default} % default, partialbg, fullbg

\newcommand{\setresumestyle}[1]{%
  \renewcommand{\resumestyle}{#1}%
  \ifthenelse{\equal{#1}{simple}}{%
    \special{pdf:put @catalog << /PageMode /UseNone >>}%
  }{%
    \ifthenelse{\equal{#1}{simplev2}}{\special{pdf:put @catalog << /PageMode /UseNone >>}}{}%
  }%
  \applyResumeLayout%
  \applyColorAndTitleStyle%
}

\newcommand{\settitlelinestyle}[1]{%
  \renewcommand{\titlelinestyle}{#1}%
  \applyColorAndTitleStyle%
}

\newcommand*{\tallphantom}[1]{\vphantom{\rule{0pt}{#1}}}
\newcommand{\ifsimpleresumestyle}[2]{%
  \ifthenelse{\equal{\resumestyle}{simple}}{#1}{%
    \ifthenelse{\equal{\resumestyle}{simplev2}}{#1}{#2}%
  }%
}
\newcommand{\ifsimplevtwo}[2]{%
  \ifthenelse{\equal{\resumestyle}{simplev2}}{#1}{#2}%
}

% Simple layout rhythm: each vertical relationship is explicit so section
% headers and body lines cannot affect one another through \baselineskip.
\newcommand*{\simpleitemlabel}{\raisebox{0.12ex}{\textbullet}}

% 标题大小
\newcommand*{\simplesectionfont}{%
  \fontsize{10pt}{11.2pt}\selectfont
  \ifsimplevtwo{\heiti\bfseries}{\bfseries}%
}
% 正文大小
\newcommand*{\simplebodysize}{9pt}
% 正文行间距
\newcommand*{\simplebodyleading}{15pt}

\newcommand*{\simplevtwonormalfontsize}{9pt}
\newcommand*{\simplevtwonormalleading}{15pt}
\newcommand*{\simplevtwonormalcolor}{resumeblack}
\newcommand*{\simplevtwonormalfontcommand}{\heiti}
\newcommand{\setsimplevtwonormalfontsize}[2]{%
  \renewcommand*{\simplevtwonormalfontsize}{#1}%
  \renewcommand*{\simplevtwonormalleading}{#2}%
}
\newcommand{\setsimplevtwonormalcolor}[1]{%
  \renewcommand*{\simplevtwonormalcolor}{#1}%
}
\newcommand{\setsimplevtwonormalfont}[1]{%
  \renewcommand*{\simplevtwonormalfontcommand}{#1}%
}
\newcommand*{\simplevtwonormalfont}{%
  \fontsize{\simplevtwonormalfontsize}{\simplevtwonormalleading}\selectfont
  \simplevtwonormalfontcommand\color{\simplevtwonormalcolor}%
}
\newcommand*{\simplevtwoentryfont}{%
  \fontsize{\simplevtwonormalfontsize}{\simplevtwonormalleading}\selectfont
  \heiti\color{resumeblack}%
}
\newcommand*{\simpleentryfont}{%
  \ifsimplevtwo{\simplevtwoentryfont}{\fontsize{\simplebodysize}{\simplebodyleading}\selectfont\bfseries}%
}
\newcommand*{\simplebodyfont}{%
  \ifsimplevtwo{\simplevtwonormalfont}{\fontsize{\simplebodysize}{\simplebodyleading}\selectfont}%
}
\newcommand*{\simplerolefont}{%
  \ifsimplevtwo{\simplevtwonormalfont\bfseries}{\fontsize{\simplebodysize}{\simplebodyleading}\selectfont\bfseries}%
}
\newcommand*{\simpledatefont}{%
  \ifsimplevtwo{\simplevtwoentryfont}{\fontsize{\simplebodysize}{\simplebodyleading}\selectfont}%
}
\newcommand{\simplevtwoaccentstrong}[1]{{\heiti\bfseries\color{simplev2red}#1}}
\newcommand{\simplevtwoaccent}[1]{{\heiti\color{simplev2red}#1}}
\newcommand{\simplevtwoem}[1]{\ifsimplevtwo{{\kaishu #1}}{{\textit{#1}}}}
\newcommand{\simplevtwostrong}[1]{\ifsimplevtwo{{\heiti\bfseries #1}}{{\textbf{#1}}}}
\newcommand*{\simpleboxgap}{8.0pt}
\newcommand*{\simplesectionfirstbeforedim}{0pt}
\newcommand*{\simplesectiontitletoruledim}{4.0pt}
\newcommand*{\simplesectionruleheight}{1.0pt}
\newcommand*{\simplebodyrowgap}{0pt}
\newcommand*{\simpleruletobodydim}{\simplebodyrowgap}
\newif\ifsimpleneedsbodygap
\newif\ifsimplefirstsection
\newif\ifsimplevvisualbalance
\simplefirstsectiontrue
\simplevvisualbalancefalse
\newsavebox{\visualbalancedresumebox}
\newsavebox{\visualbalancedresumescratchbox}
\newdimen\visualbalancedresumeheight
% Align visible ink, not only TeX's measured box, for the raised simple_v2 header.
\newcommand*{\visualbalancedresumevisualoffset}{-24pt}

\newcommand{\applyResumeLayout}{%
  \ifsimpleresumestyle{%
    \newgeometry{left=48pt,right=48pt,top=57pt,bottom=0.52in,nohead}%
    \setlist{nosep}%
    \setlist[itemize]{topsep=0pt, partopsep=0pt, parsep=0pt, itemsep=0pt, leftmargin=1.65em, labelwidth=0.22em, labelsep=0.35em, label=\simpleitemlabel, before=\simplebodyfont}%
    \setlist[enumerate]{topsep=0pt, partopsep=0pt, parsep=0pt, itemsep=0pt, leftmargin=1.15em, before=\simplebodyfont}%
    \titleformat{\subsection}
      {\normalsize\bfseries\raggedright}
      {}{0em}
      {}%
    \titlespacing*{\subsection}{0cm}{0pt}{0pt}%
    \simplefirstsectiontrue
    \simpleneedsbodygapfalse
    \simplebodyfont
  }{%
    \ifthenelse{\equal{\resumestyle}{classic}}{%
      \newgeometry{left=0.80in,right=0.80in,top=0.85in,bottom=0.55in,nohead}%
      \setlist{noitemsep}%
      \setlist[itemize]{topsep=0.25em, leftmargin=1.25pc}%
      \setlist[enumerate]{topsep=0.25em, leftmargin=1.25pc}%
      \titleformat{\subsection}
        {\large\raggedright}
        {}{0em}
        {}%
      \titlespacing*{\subsection}{0cm}{*1.8}{*0.6}%
    }{%
      \PackageError{resume}{Invalid value for resumestyle: \resumestyle}{}%
    }%
  }%
}

\NewDocumentEnvironment{visualbalancedresume}{+b}{%
  \ifsimplevtwo{%
    \begingroup
      \simplevvisualbalancetrue
      \setbox\visualbalancedresumescratchbox=\vbox{%
        \hsize=\linewidth
        \linewidth=\hsize
        \parindent=0pt
        #1%
      }%
      \global\visualbalancedresumeheight=\dimexpr\ht\visualbalancedresumescratchbox+\dp\visualbalancedresumescratchbox\relax
      \global\setbox\visualbalancedresumebox=\copy\visualbalancedresumescratchbox
    \endgroup
    \ifdim\visualbalancedresumeheight<\paperheight
      \thispagestyle{empty}%
      \enlargethispage{\dimexpr\paperheight-\textheight\relax}%
      \vspace*{\dimexpr -1in-\voffset-\topmargin-\headheight-\headsep\relax}%
      \noindent\vbox to \paperheight{%
        \vfil
        \vspace*{\visualbalancedresumevisualoffset}%
        \noindent\box\visualbalancedresumebox
        \vfil
      }\par
    \else
      \simplevvisualbalancefalse
      #1%
    \fi
  }{%
    #1%
  }%
}{}

\newcommand{\applyColorAndTitleStyle}{%
  \ifsimpleresumestyle{%
    \colorlet{fgcolor}{resumeblack}%
    \ifsimplevtwo{%
      \colorlet{accentcolor}{simplev2red}%
    }{%
      \colorlet{accentcolor}{resumeblack}%
    }%
    \titleformat{\section}
      {\normalsize\bfseries\raggedright\color{fgcolor}}
      {}{0em}
      {}%
    \titlespacing*{\section}{0cm}{0pt}{0pt}%
  }{%
    \ifthenelse{\equal{\titlelinestyle}{default}}{%
      \colorlet{fgcolor}{nwpubluebg} %
      \colorlet{accentcolor}{nwpubluebg} %
      \titleformat{\section}         % Customise the \section command
        {\Large\bfseries\raggedright\color{fgcolor}} % Make the \section headers large (\Large),
                                     % small capitals (\scshape) -> bold font (\bfseries),
                                     % left aligned (\raggedright) and use fgcolor
        {}{0em}                      % Can be used to give a prefix to all sections, like 'Section ...'
        {}                           % Can be used to insert code before the heading
        % {\colorbox{fgcolor}{\makebox[0.1em][l]{\strut\tallphantom{16pt}}}} % 有 icon 没必要用这个
        [\titleline{\color{fgcolor}\titlerule}] % Default inserts a horizontal line after the heading
        % REF: https://tex.stackexchange.com/a/40089
      \titlespacing*{\section}{0cm}{*1.8}{*1.8}%
    }{%
      \colorlet{bgcolor}{cyanbg}%
      \colorlet{fgcolor}{cyanfg}%
      \colorlet{accentcolor}{black}%
      \ifthenelse{\equal{\titlelinestyle}{partialbg}}{%
        \titleformat{\section}
          {\Large\bfseries\raggedright\color{fgcolor}}
          {}{0em}%
          {}
          [\titleline{\color{fgcolor}\titlerule}]%
        \titlespacing*{\section}{0cm}{*1.8}{*1.8}%
      }{%
        \ifthenelse{\equal{\titlelinestyle}{fullbg}}{%
          \titleformat{\section}
            {\Large\bfseries\raggedright\color{fgcolor}}
            {}{0em}
            {}%
          \titlespacing*{\section}{0cm}{*1.8}{*1.8}%
        }{%
          \PackageError{resume}{Invalid value for titlelinestyle: \titlelinestyle}{}%
        }%
      }%
    }%
  }%
}
\AtBeginDocument{\applyResumeLayout\applyColorAndTitleStyle}

\titleformat{\subsection}
  {\large\raggedright}
  {}{0em}
  {}
\titlespacing*{\subsection}{0cm}{*1.8}{*0.6}

\newcommand{\datedsection}[2]{%
  \section[#1]{#1 \hfill #2}%
}
\newcommand{\datedsubsection}[2]{%
  \ifthenelse{\equal{\resumestyle}{simple}}{%
    \simplebodyrow{{\simplebodyfont #1 \hfill {\simpledatefont #2}}}%
  }{%
    \ifthenelse{\equal{\resumestyle}{simplev2}}{%
      \simplebodyrow{{\simpleentryfont #1 \hfill {\simpledatefont #2}}}%
    }{%
      \subsection[#1]{#1 \hfill #2}%
    }%
  }%
}
\newcommand{\datedline}[2]{%
  \ifsimpleresumestyle{%
    \simplebodyrow{#1 \hfill #2}%
  }{%
    {\par #1 \hfill #2 \par}%
  }%
}

\newcommand{\simplebodyrow}[1]{%
  \par
  \ifsimpleneedsbodygap
    \vspace{\simplebodyrowgap}%
  \else
    \simpleneedsbodygaptrue
  \fi
  \noindent{\simplebodyfont #1}\par
}

\newcommand{\simplesectionline}[1]{%
  \par
  \ifsimplefirstsection
    \vspace{\simplesectionfirstbeforedim}%
    \simplefirstsectionfalse
  \else
    \vspace{\simpleboxgap}%
  \fi
  \noindent\vbox{%
    \hsize=\linewidth
    \hbox{\simplesectionfont #1}%
    \vskip \simplesectiontitletoruledim
    \hrule height \simplesectionruleheight width \hsize
  }%
  \par\nobreak\vspace{\simpleruletobodydim}%
  \simpleneedsbodygapfalse
}

\newcommand{\name}[1]{%
  \ifsimpleresumestyle{%
    \centerline{\Large\bfseries{#1}}%
    \vspace{0.8ex}%
  }{%
    \centerline{\Huge\bfseries{#1}}%
    \vspace{1.5ex}%
  }%
}

% defines one's name
% usage: \name{<name>}
\newcommand{\nameTest}[1]{
  {\large\bfseries{#1}}
}

% Title
\newcommand*{\sectionTitle}[2]{%
  \ifsimpleresumestyle{%
    \simplesectionline{#1}%
  }{%
    \ifthenelse{\equal{\titlelinestyle}{default}}{%
      \section{%
        \texorpdfstring%
          {\icon{#2} #1}% 标题无背景色 有下划线
          {#1}%
      }%
    }{%
      \ifthenelse{\equal{\titlelinestyle}{partialbg}}{%
        \section{%
          \texorpdfstring%
            % {\colorbox{bgcolor}{\color{fgcolor}{\icon{#2} #1}\strut\tallphantom{16pt}}}% 上下 pad
            {\colorbox{bgcolor}{\icon{#2} #1}}% 标题内容部分背景色 可加下划线
            {#1}%
        }%
      }{%
        \ifthenelse{\equal{\titlelinestyle}{fullbg}}{%
          \section{%
            \texorpdfstring%
              % 可以试试 makebox 置顶放 + tallphantom
              % {\colorbox{bgcolor}{\makebox[\textwidth - 6pt][l]{\icon{#2} #1}\strut\tallphantom{16pt}}}%
              {\colorbox{bgcolor}{\makebox[\textwidth - 6pt][l]{\icon{#2} #1}}}% 标题整行背景色 不要加下划线
              {#1}%
          }%
        }{%
          \PackageError{resume}{Invalid value for titlelinestyle: \titlelinestyle}{}%
        }%
      }%
    }%
  }%
}

% REF: [resume/resume.cls at master · liweitianux/resume](https://github.com/liweitianux/resume/blob/master/resume.cls)
\def\@iconsize{\normalsize}
\newcommand*{\iconsize}[1]{\def\@iconsize{#1}}

% icon 不设定 size 和 color 在其外层设定
\newcommand*{\icon}[1]{%
  % {\@iconsize{\large}\makebox[1em][c]{\textcolor{fgcolor}{#1}}}%
  {\makebox[1em][c]{#1}}%
  \hspace{0.3em}%\strut%
}

% defines one's email
% usage: \email{<email>}
\newcommand{\email}[1]{\basicInfoItem{\faiconsixbf{envelope}}{\href{mailto:#1}{#1}}}

% defines one's phone
% usage: \phone{<phone>}
\newcommand{\phone}[1]{\basicInfoItem{\faiconsixbf{phone}}{#1}}

\newcommand{\code}[1]{\basicInfoItem{\faiconsixbf{code}}{#1}}

\newcommand{\identity}[1]{\basicInfoItem{\faiconsixbf{address-card}}{#1}}

% also: calendar-days, calendar-week, calendar-minus, calendar-plus
\newcommand{\calendar}[1]{\basicInfoItem{\faiconsixbf{calendar}}{#1}}

\newcommand{\birthday}[1]{\basicInfoItem{\faiconsixbf{cake-candles}}{#1}}

\newcommand{\hometown}[1]{\basicInfoItem{\faiconsixbf{house}}{#1}}

\newcommand{\boy}{\basicInfoItem{\faiconsixbf{mars}}{男}}
\newcommand{\girl}{\basicInfoItem{\faiconsixbf{venus}}{女}}

% defines one's linkedin
% usage: \linkedin{<linkedin>}
\newcommand{\linkedin}[2][]{\basicInfoItem{\faiconsix{linkedin-in}}
  {\ifthenelse{\isempty{#1}}%
    {\href{#2}{#2}}
    {\href{#2}{#1}}}}
\newcommand{\linkedinsquare}[2][]{\basicInfoItem{\faiconsix{linkedin}}
  {\ifthenelse{\isempty{#1}}%
    {\href{#2}{#2}}
    {\href{#2}{#1}}}}

% defines one's GitHub
% usage: \github{<github>}
\newcommand{\github}[2][]{\basicInfoItem{\faiconsix{github}}
  {\ifthenelse{\isempty{#1}}%
    {\href{#2}{#2}}
    {\href{#2}{#1}}}}

% defines one's homepage
% usage: \homepage{<homepage>}
\newcommand{\homepage}[2][]{\basicInfoItem{\faiconsixbf{link}}
  {\ifthenelse{\isempty{#1}}%
    {\href{#2}{#2}}
    {\href{#2}{#1}}}}

% \newcommand{\basicInfoItem}[2]{\color{fgcolor}{\icon{#1}}\ \color{black}\rmfamily\large{#2}}
\newcommand{\basicInfoItem}[2]{%
  \ifsimpleresumestyle%
    {\rmfamily\small{#2}}%
    {\icon{#1}\ \rmfamily\large{#2}}%
}

\newcommand{\dotSep}{%
  \ifsimpleresumestyle{\quad}{\ \ \textbf{\textperiodcentered}\ \ }%
}

\newcommand{\basicInfo}[1]{%
  % \centerline{\sffamily\large{#1}}
  \centerline{#1}%
  \ifsimpleresumestyle{}{\vspace{1.5ex}}%
}

\newcommand{\role}[2]{%
  \ifsimpleresumestyle{%
    \simplebodyrow{{\simplerolefont #1}\ {\simplebodyfont #2}}%
  }{%
    {\par \textit{#1} ~ #2 \par}%
    \vspace{0.6ex}%
  }%
}

\newcommand{\texthl}[1]{\ifsimplevtwo{\simplevtwoaccentstrong{#1}}{\textcolor{accentcolor}{\textbf{#1}}}}

\newcommand{\normalline}[1]{%
  \ifsimpleresumestyle{%
    \simplebodyrow{#1}%
  }{%
    \par #1 \par
  }%
}

\setlength{\parskip}{0pt}
