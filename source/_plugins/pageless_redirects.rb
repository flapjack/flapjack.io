




<!DOCTYPE html>
<html class="   ">
  <head prefix="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb# object: http://ogp.me/ns/object# article: http://ogp.me/ns/article# profile: http://ogp.me/ns/profile#">
    <meta charset='utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    
    
    <title>jekyll-pageless-redirects/pageless_redirects.rb at master · nquinlan/jekyll-pageless-redirects · GitHub</title>
    <link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="GitHub" />
    <link rel="fluid-icon" href="https://github.com/fluidicon.png" title="GitHub" />
    <link rel="apple-touch-icon" sizes="57x57" href="/apple-touch-icon-114.png" />
    <link rel="apple-touch-icon" sizes="114x114" href="/apple-touch-icon-114.png" />
    <link rel="apple-touch-icon" sizes="72x72" href="/apple-touch-icon-144.png" />
    <link rel="apple-touch-icon" sizes="144x144" href="/apple-touch-icon-144.png" />
    <meta property="fb:app_id" content="1401488693436528"/>

      <meta content="@github" name="twitter:site" /><meta content="summary" name="twitter:card" /><meta content="nquinlan/jekyll-pageless-redirects" name="twitter:title" /><meta content="jekyll-pageless-redirects - Generates redirect pages based on YAML or htaccess style redirects." name="twitter:description" /><meta content="https://avatars0.githubusercontent.com/u/829864?s=400" name="twitter:image:src" />
<meta content="GitHub" property="og:site_name" /><meta content="object" property="og:type" /><meta content="https://avatars0.githubusercontent.com/u/829864?s=400" property="og:image" /><meta content="nquinlan/jekyll-pageless-redirects" property="og:title" /><meta content="https://github.com/nquinlan/jekyll-pageless-redirects" property="og:url" /><meta content="jekyll-pageless-redirects - Generates redirect pages based on YAML or htaccess style redirects." property="og:description" />

    <link rel="assets" href="https://assets-cdn.github.com/">
    <link rel="conduit-xhr" href="https://ghconduit.com:25035">
    

    <meta name="msapplication-TileImage" content="/windows-tile.png" />
    <meta name="msapplication-TileColor" content="#ffffff" />
    <meta name="selected-link" value="repo_source" data-pjax-transient />
      <meta name="google-analytics" content="UA-3769691-2">

    <meta content="collector.githubapp.com" name="octolytics-host" /><meta content="collector-cdn.github.com" name="octolytics-script-host" /><meta content="github" name="octolytics-app-id" /><meta content="DCE90594:7281:C73514:53CF73EA" name="octolytics-dimension-request_id" />
    

    
    
    <link rel="icon" type="image/x-icon" href="https://assets-cdn.github.com/favicon.ico" />


    <meta content="authenticity_token" name="csrf-param" />
<meta content="B6vxYxgq1/cdENGWo9FyCO4uKrXe4L2FqS9FL1623LN9DmJQnM+vpuuG032dj71wJddhlYSSn1N4+CIiabFYNA==" name="csrf-token" />

    <link href="https://assets-cdn.github.com/assets/github-3c35fa891ec60684eddfbf111543a34660ac7e5b.css" media="all" rel="stylesheet" type="text/css" />
    <link href="https://assets-cdn.github.com/assets/github2-f3218de7e979dec2faca17bdc18ddcfb6aba4723.css" media="all" rel="stylesheet" type="text/css" />
    


    <meta http-equiv="x-pjax-version" content="12971954cccc74375b648688414c382b">

      
  <meta name="description" content="jekyll-pageless-redirects - Generates redirect pages based on YAML or htaccess style redirects." />


  <meta content="829864" name="octolytics-dimension-user_id" /><meta content="nquinlan" name="octolytics-dimension-user_login" /><meta content="12521874" name="octolytics-dimension-repository_id" /><meta content="nquinlan/jekyll-pageless-redirects" name="octolytics-dimension-repository_nwo" /><meta content="true" name="octolytics-dimension-repository_public" /><meta content="false" name="octolytics-dimension-repository_is_fork" /><meta content="12521874" name="octolytics-dimension-repository_network_root_id" /><meta content="nquinlan/jekyll-pageless-redirects" name="octolytics-dimension-repository_network_root_nwo" />

  <link href="https://github.com/nquinlan/jekyll-pageless-redirects/commits/master.atom" rel="alternate" title="Recent Commits to jekyll-pageless-redirects:master" type="application/atom+xml" />

  </head>


  <body class="logged_out  env-production  vis-public page-blob">
    <a href="#start-of-content" tabindex="1" class="accessibility-aid js-skip-to-content">Skip to content</a>
    <div class="wrapper">
      
      
      
      


      
      <div class="header header-logged-out">
  <div class="container clearfix">

    <a class="header-logo-wordmark" href="https://github.com/">
      <span class="mega-octicon octicon-logo-github"></span>
    </a>

    <div class="header-actions">
        <a class="button primary" href="/join">Sign up</a>
      <a class="button signin" href="/login?return_to=%2Fnquinlan%2Fjekyll-pageless-redirects%2Fblob%2Fmaster%2Fpageless_redirects.rb">Sign in</a>
    </div>

    <div class="command-bar js-command-bar  in-repository">

      <ul class="top-nav">
          <li class="explore"><a href="/explore">Explore</a></li>
          <li class="features"><a href="/features">Features</a></li>
          <li class="enterprise"><a href="https://enterprise.github.com/">Enterprise</a></li>
          <li class="blog"><a href="/blog">Blog</a></li>
      </ul>
        <form accept-charset="UTF-8" action="/search" class="command-bar-form" id="top_search_form" method="get">

<div class="commandbar">
  <span class="message"></span>
  <input type="text" data-hotkey="s, /" name="q" id="js-command-bar-field" placeholder="Search or type a command" tabindex="1" autocapitalize="off"
    
    
    data-repo="nquinlan/jekyll-pageless-redirects"
  >
  <div class="display hidden"></div>
</div>

    <input type="hidden" name="nwo" value="nquinlan/jekyll-pageless-redirects" />

    <div class="select-menu js-menu-container js-select-menu search-context-select-menu">
      <span class="minibutton select-menu-button js-menu-target" role="button" aria-haspopup="true">
        <span class="js-select-button">This repository</span>
      </span>

      <div class="select-menu-modal-holder js-menu-content js-navigation-container" aria-hidden="true">
        <div class="select-menu-modal">

          <div class="select-menu-item js-navigation-item js-this-repository-navigation-item selected">
            <span class="select-menu-item-icon octicon octicon-check"></span>
            <input type="radio" class="js-search-this-repository" name="search_target" value="repository" checked="checked" />
            <div class="select-menu-item-text js-select-button-text">This repository</div>
          </div> <!-- /.select-menu-item -->

          <div class="select-menu-item js-navigation-item js-all-repositories-navigation-item">
            <span class="select-menu-item-icon octicon octicon-check"></span>
            <input type="radio" name="search_target" value="global" />
            <div class="select-menu-item-text js-select-button-text">All repositories</div>
          </div> <!-- /.select-menu-item -->

        </div>
      </div>
    </div>

  <span class="help tooltipped tooltipped-s" aria-label="Show command bar help">
    <span class="octicon octicon-question"></span>
  </span>


  <input type="hidden" name="ref" value="cmdform">

</form>
    </div>

  </div>
</div>



      <div id="start-of-content" class="accessibility-aid"></div>
          <div class="site" itemscope itemtype="http://schema.org/WebPage">
    <div id="js-flash-container">
      
    </div>
    <div class="pagehead repohead instapaper_ignore readability-menu">
      <div class="container">
        
<ul class="pagehead-actions">


  <li>
      <a href="/login?return_to=%2Fnquinlan%2Fjekyll-pageless-redirects"
    class="minibutton with-count star-button tooltipped tooltipped-n"
    aria-label="You must be signed in to star a repository" rel="nofollow">
    <span class="octicon octicon-star"></span>
    Star
  </a>

    <a class="social-count js-social-count" href="/nquinlan/jekyll-pageless-redirects/stargazers">
      28
    </a>

  </li>

    <li>
      <a href="/login?return_to=%2Fnquinlan%2Fjekyll-pageless-redirects"
        class="minibutton with-count js-toggler-target fork-button tooltipped tooltipped-n"
        aria-label="You must be signed in to fork a repository" rel="nofollow">
        <span class="octicon octicon-repo-forked"></span>
        Fork
      </a>
      <a href="/nquinlan/jekyll-pageless-redirects/network" class="social-count">
        4
      </a>
    </li>
</ul>

        <h1 itemscope itemtype="http://data-vocabulary.org/Breadcrumb" class="entry-title public">
          <span class="repo-label"><span>public</span></span>
          <span class="mega-octicon octicon-repo"></span>
          <span class="author"><a href="/nquinlan" class="url fn" itemprop="url" rel="author"><span itemprop="title">nquinlan</span></a></span><!--
       --><span class="path-divider">/</span><!--
       --><strong><a href="/nquinlan/jekyll-pageless-redirects" class="js-current-repository js-repo-home-link">jekyll-pageless-redirects</a></strong>

          <span class="page-context-loader">
            <img alt="" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
          </span>

        </h1>
      </div><!-- /.container -->
    </div><!-- /.repohead -->

    <div class="container">
      <div class="repository-with-sidebar repo-container new-discussion-timeline js-new-discussion-timeline  ">
        <div class="repository-sidebar clearfix">
            

<div class="sunken-menu vertical-right repo-nav js-repo-nav js-repository-container-pjax js-octicon-loaders" data-issue-count-url="/nquinlan/jekyll-pageless-redirects/issues/counts">
  <div class="sunken-menu-contents">
    <ul class="sunken-menu-group">
      <li class="tooltipped tooltipped-w" aria-label="Code">
        <a href="/nquinlan/jekyll-pageless-redirects" aria-label="Code" class="selected js-selected-navigation-item sunken-menu-item" data-hotkey="g c" data-pjax="true" data-selected-links="repo_source repo_downloads repo_commits repo_releases repo_tags repo_branches /nquinlan/jekyll-pageless-redirects">
          <span class="octicon octicon-code"></span> <span class="full-word">Code</span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>

        <li class="tooltipped tooltipped-w" aria-label="Issues">
          <a href="/nquinlan/jekyll-pageless-redirects/issues" aria-label="Issues" class="js-selected-navigation-item sunken-menu-item js-disable-pjax" data-hotkey="g i" data-selected-links="repo_issues repo_labels repo_milestones /nquinlan/jekyll-pageless-redirects/issues">
            <span class="octicon octicon-issue-opened"></span> <span class="full-word">Issues</span>
            <span class="js-issue-replace-counter"></span>
            <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>        </li>

      <li class="tooltipped tooltipped-w" aria-label="Pull Requests">
        <a href="/nquinlan/jekyll-pageless-redirects/pulls" aria-label="Pull Requests" class="js-selected-navigation-item sunken-menu-item js-disable-pjax" data-hotkey="g p" data-selected-links="repo_pulls /nquinlan/jekyll-pageless-redirects/pulls">
            <span class="octicon octicon-git-pull-request"></span> <span class="full-word">Pull Requests</span>
            <span class="js-pull-replace-counter"></span>
            <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>


    </ul>
    <div class="sunken-menu-separator"></div>
    <ul class="sunken-menu-group">

      <li class="tooltipped tooltipped-w" aria-label="Pulse">
        <a href="/nquinlan/jekyll-pageless-redirects/pulse" aria-label="Pulse" class="js-selected-navigation-item sunken-menu-item" data-pjax="true" data-selected-links="pulse /nquinlan/jekyll-pageless-redirects/pulse">
          <span class="octicon octicon-pulse"></span> <span class="full-word">Pulse</span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>

      <li class="tooltipped tooltipped-w" aria-label="Graphs">
        <a href="/nquinlan/jekyll-pageless-redirects/graphs" aria-label="Graphs" class="js-selected-navigation-item sunken-menu-item" data-pjax="true" data-selected-links="repo_graphs repo_contributors /nquinlan/jekyll-pageless-redirects/graphs">
          <span class="octicon octicon-graph"></span> <span class="full-word">Graphs</span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>
    </ul>


  </div>
</div>

              <div class="only-with-full-nav">
                

  

<div class="clone-url open"
  data-protocol-type="http"
  data-url="/users/set_protocol?protocol_selector=http&amp;protocol_type=clone">
  <h3><strong>HTTPS</strong> clone URL</h3>
  <div class="clone-url-box">
    <input type="text" class="clone js-url-field"
           value="https://github.com/nquinlan/jekyll-pageless-redirects.git" readonly="readonly">
    <span class="url-box-clippy">
    <button aria-label="Copy to clipboard" class="js-zeroclipboard minibutton zeroclipboard-button" data-clipboard-text="https://github.com/nquinlan/jekyll-pageless-redirects.git" data-copied-hint="Copied!" type="button"><span class="octicon octicon-clippy"></span></button>
    </span>
  </div>
</div>

  

<div class="clone-url "
  data-protocol-type="subversion"
  data-url="/users/set_protocol?protocol_selector=subversion&amp;protocol_type=clone">
  <h3><strong>Subversion</strong> checkout URL</h3>
  <div class="clone-url-box">
    <input type="text" class="clone js-url-field"
           value="https://github.com/nquinlan/jekyll-pageless-redirects" readonly="readonly">
    <span class="url-box-clippy">
    <button aria-label="Copy to clipboard" class="js-zeroclipboard minibutton zeroclipboard-button" data-clipboard-text="https://github.com/nquinlan/jekyll-pageless-redirects" data-copied-hint="Copied!" type="button"><span class="octicon octicon-clippy"></span></button>
    </span>
  </div>
</div>


<p class="clone-options">You can clone with
      <a href="#" class="js-clone-selector" data-protocol="http">HTTPS</a>
      or <a href="#" class="js-clone-selector" data-protocol="subversion">Subversion</a>.
  <a href="https://help.github.com/articles/which-remote-url-should-i-use" class="help tooltipped tooltipped-n" aria-label="Get help on which URL is right for you.">
    <span class="octicon octicon-question"></span>
  </a>
</p>



                <a href="/nquinlan/jekyll-pageless-redirects/archive/master.zip"
                   class="minibutton sidebar-button"
                   aria-label="Download nquinlan/jekyll-pageless-redirects as a zip file"
                   title="Download nquinlan/jekyll-pageless-redirects as a zip file"
                   rel="nofollow">
                  <span class="octicon octicon-cloud-download"></span>
                  Download ZIP
                </a>
              </div>
        </div><!-- /.repository-sidebar -->

        <div id="js-repo-pjax-container" class="repository-content context-loader-container" data-pjax-container>
          


<a href="/nquinlan/jekyll-pageless-redirects/blob/3d09495f83875e3e34d804566022ac543d13396c/pageless_redirects.rb" class="hidden js-permalink-shortcut" data-hotkey="y">Permalink</a>

<!-- blob contrib key: blob_contributors:v21:5fbfc1027fabd57ec75ff261e796b81c -->

<p title="This is a placeholder element" class="js-history-link-replace hidden"></p>

<div class="file-navigation">
  

<div class="select-menu js-menu-container js-select-menu" >
  <span class="minibutton select-menu-button js-menu-target css-truncate" data-hotkey="w"
    data-master-branch="master"
    data-ref="master"
    title="master"
    role="button" aria-label="Switch branches or tags" tabindex="0" aria-haspopup="true">
    <span class="octicon octicon-git-branch"></span>
    <i>branch:</i>
    <span class="js-select-button css-truncate-target">master</span>
  </span>

  <div class="select-menu-modal-holder js-menu-content js-navigation-container" data-pjax aria-hidden="true">

    <div class="select-menu-modal">
      <div class="select-menu-header">
        <span class="select-menu-title">Switch branches/tags</span>
        <span class="octicon octicon-x js-menu-close" role="button" aria-label="Close"></span>
      </div> <!-- /.select-menu-header -->

      <div class="select-menu-filters">
        <div class="select-menu-text-filter">
          <input type="text" aria-label="Filter branches/tags" id="context-commitish-filter-field" class="js-filterable-field js-navigation-enable" placeholder="Filter branches/tags">
        </div>
        <div class="select-menu-tabs">
          <ul>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="branches" class="js-select-menu-tab">Branches</a>
            </li>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="tags" class="js-select-menu-tab">Tags</a>
            </li>
          </ul>
        </div><!-- /.select-menu-tabs -->
      </div><!-- /.select-menu-filters -->

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="branches">

        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


            <div class="select-menu-item js-navigation-item selected">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/nquinlan/jekyll-pageless-redirects/blob/master/pageless_redirects.rb"
                 data-name="master"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text css-truncate-target"
                 title="master">master</a>
            </div> <!-- /.select-menu-item -->
        </div>

          <div class="select-menu-no-results">Nothing to show</div>
      </div> <!-- /.select-menu-list -->

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="tags">
        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


        </div>

        <div class="select-menu-no-results">Nothing to show</div>
      </div> <!-- /.select-menu-list -->

    </div> <!-- /.select-menu-modal -->
  </div> <!-- /.select-menu-modal-holder -->
</div> <!-- /.select-menu -->

  <div class="button-group right">
    <a href="/nquinlan/jekyll-pageless-redirects/find/master"
          class="js-show-file-finder minibutton empty-icon tooltipped tooltipped-s"
          data-pjax
          data-hotkey="t"
          aria-label="Quickly jump between files">
      <span class="octicon octicon-list-unordered"></span>
    </a>
    <button class="js-zeroclipboard minibutton zeroclipboard-button"
          data-clipboard-text="pageless_redirects.rb"
          aria-label="Copy to clipboard"
          data-copied-hint="Copied!">
      <span class="octicon octicon-clippy"></span>
    </button>
  </div>

  <div class="breadcrumb">
    <span class='repo-root js-repo-root'><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/nquinlan/jekyll-pageless-redirects" data-branch="master" data-direction="back" data-pjax="true" itemscope="url"><span itemprop="title">jekyll-pageless-redirects</span></a></span></span><span class="separator"> / </span><strong class="final-path">pageless_redirects.rb</strong>
  </div>
</div>


  <div class="commit file-history-tease">
      <img alt="Nick Quinlan" class="main-avatar js-avatar" data-user="829864" height="24" src="https://avatars3.githubusercontent.com/u/829864?s=140" width="24" />
      <span class="author"><a href="/nquinlan" rel="author">nquinlan</a></span>
      <time datetime="2014-03-26T17:02:35-07:00" is="relative-time">March 26, 2014</time>
      <div class="commit-title">
          <a href="/nquinlan/jekyll-pageless-redirects/commit/3c1318439336c8f2d8356e684cdc5277b3ae6ddc" class="message" data-pjax="true" title="named variables to be a little more transparent">named variables to be a little more transparent</a>
      </div>

    <div class="participation">
      <p class="quickstat"><a href="#blob_contributors_box" rel="facebox"><strong>4</strong>  contributors</a></p>
          <a class="avatar tooltipped tooltipped-s" aria-label="nquinlan" href="/nquinlan/jekyll-pageless-redirects/commits/master/pageless_redirects.rb?author=nquinlan"><img alt="Nick Quinlan" class=" js-avatar" data-user="829864" height="20" src="https://avatars3.githubusercontent.com/u/829864?s=140" width="20" /></a>
    <a class="avatar tooltipped tooltipped-s" aria-label="janslow" href="/nquinlan/jekyll-pageless-redirects/commits/master/pageless_redirects.rb?author=janslow"><img alt="Jay Anslow" class=" js-avatar" data-user="1253367" height="20" src="https://avatars1.githubusercontent.com/u/1253367?s=140" width="20" /></a>
    <a class="avatar tooltipped tooltipped-s" aria-label="takuti" href="/nquinlan/jekyll-pageless-redirects/commits/master/pageless_redirects.rb?author=takuti"><img alt="takuti" class=" js-avatar" data-user="853567" height="20" src="https://avatars3.githubusercontent.com/u/853567?s=140" width="20" /></a>
    <a class="avatar tooltipped tooltipped-s" aria-label="ws" href="/nquinlan/jekyll-pageless-redirects/commits/master/pageless_redirects.rb?author=ws"><img alt="Will Smidlein" class=" js-avatar" data-user="409133" height="20" src="https://avatars2.githubusercontent.com/u/409133?s=140" width="20" /></a>


    </div>
    <div id="blob_contributors_box" style="display:none">
      <h2 class="facebox-header">Users who have contributed to this file</h2>
      <ul class="facebox-user-list">
          <li class="facebox-user-list-item">
            <img alt="Nick Quinlan" class=" js-avatar" data-user="829864" height="24" src="https://avatars3.githubusercontent.com/u/829864?s=140" width="24" />
            <a href="/nquinlan">nquinlan</a>
          </li>
          <li class="facebox-user-list-item">
            <img alt="Jay Anslow" class=" js-avatar" data-user="1253367" height="24" src="https://avatars1.githubusercontent.com/u/1253367?s=140" width="24" />
            <a href="/janslow">janslow</a>
          </li>
          <li class="facebox-user-list-item">
            <img alt="takuti" class=" js-avatar" data-user="853567" height="24" src="https://avatars3.githubusercontent.com/u/853567?s=140" width="24" />
            <a href="/takuti">takuti</a>
          </li>
          <li class="facebox-user-list-item">
            <img alt="Will Smidlein" class=" js-avatar" data-user="409133" height="24" src="https://avatars2.githubusercontent.com/u/409133?s=140" width="24" />
            <a href="/ws">ws</a>
          </li>
      </ul>
    </div>
  </div>

<div class="file-box">
  <div class="file">
    <div class="meta clearfix">
      <div class="info file-name">
        <span class="icon"><b class="octicon octicon-file-text"></b></span>
        <span class="mode" title="File Mode">file</span>
        <span class="meta-divider"></span>
          <span>166 lines (145 sloc)</span>
          <span class="meta-divider"></span>
        <span>4.979 kb</span>
      </div>
      <div class="actions">
        <div class="button-group">
              <a class="minibutton disabled tooltipped tooltipped-w" href="#"
                 aria-label="You must be signed in to make or propose changes">Edit</a>
          <a href="/nquinlan/jekyll-pageless-redirects/raw/master/pageless_redirects.rb" class="minibutton " id="raw-url">Raw</a>
            <a href="/nquinlan/jekyll-pageless-redirects/blame/master/pageless_redirects.rb" class="minibutton js-update-url-with-hash">Blame</a>
          <a href="/nquinlan/jekyll-pageless-redirects/commits/master/pageless_redirects.rb" class="minibutton " rel="nofollow">History</a>
        </div><!-- /.button-group -->
          <a class="minibutton danger disabled empty-icon tooltipped tooltipped-w" href="#"
             aria-label="You must be signed in to make or propose changes">
          Delete
        </a>
      </div><!-- /.actions -->
    </div>
      
  <div class="blob-wrapper data type-ruby js-blob-data">
       <table class="file-code file-diff tab-size-8">
         <tr class="file-code-line">
           <td class="blob-line-nums">
             <span id="L1" rel="#L1">1</span>
<span id="L2" rel="#L2">2</span>
<span id="L3" rel="#L3">3</span>
<span id="L4" rel="#L4">4</span>
<span id="L5" rel="#L5">5</span>
<span id="L6" rel="#L6">6</span>
<span id="L7" rel="#L7">7</span>
<span id="L8" rel="#L8">8</span>
<span id="L9" rel="#L9">9</span>
<span id="L10" rel="#L10">10</span>
<span id="L11" rel="#L11">11</span>
<span id="L12" rel="#L12">12</span>
<span id="L13" rel="#L13">13</span>
<span id="L14" rel="#L14">14</span>
<span id="L15" rel="#L15">15</span>
<span id="L16" rel="#L16">16</span>
<span id="L17" rel="#L17">17</span>
<span id="L18" rel="#L18">18</span>
<span id="L19" rel="#L19">19</span>
<span id="L20" rel="#L20">20</span>
<span id="L21" rel="#L21">21</span>
<span id="L22" rel="#L22">22</span>
<span id="L23" rel="#L23">23</span>
<span id="L24" rel="#L24">24</span>
<span id="L25" rel="#L25">25</span>
<span id="L26" rel="#L26">26</span>
<span id="L27" rel="#L27">27</span>
<span id="L28" rel="#L28">28</span>
<span id="L29" rel="#L29">29</span>
<span id="L30" rel="#L30">30</span>
<span id="L31" rel="#L31">31</span>
<span id="L32" rel="#L32">32</span>
<span id="L33" rel="#L33">33</span>
<span id="L34" rel="#L34">34</span>
<span id="L35" rel="#L35">35</span>
<span id="L36" rel="#L36">36</span>
<span id="L37" rel="#L37">37</span>
<span id="L38" rel="#L38">38</span>
<span id="L39" rel="#L39">39</span>
<span id="L40" rel="#L40">40</span>
<span id="L41" rel="#L41">41</span>
<span id="L42" rel="#L42">42</span>
<span id="L43" rel="#L43">43</span>
<span id="L44" rel="#L44">44</span>
<span id="L45" rel="#L45">45</span>
<span id="L46" rel="#L46">46</span>
<span id="L47" rel="#L47">47</span>
<span id="L48" rel="#L48">48</span>
<span id="L49" rel="#L49">49</span>
<span id="L50" rel="#L50">50</span>
<span id="L51" rel="#L51">51</span>
<span id="L52" rel="#L52">52</span>
<span id="L53" rel="#L53">53</span>
<span id="L54" rel="#L54">54</span>
<span id="L55" rel="#L55">55</span>
<span id="L56" rel="#L56">56</span>
<span id="L57" rel="#L57">57</span>
<span id="L58" rel="#L58">58</span>
<span id="L59" rel="#L59">59</span>
<span id="L60" rel="#L60">60</span>
<span id="L61" rel="#L61">61</span>
<span id="L62" rel="#L62">62</span>
<span id="L63" rel="#L63">63</span>
<span id="L64" rel="#L64">64</span>
<span id="L65" rel="#L65">65</span>
<span id="L66" rel="#L66">66</span>
<span id="L67" rel="#L67">67</span>
<span id="L68" rel="#L68">68</span>
<span id="L69" rel="#L69">69</span>
<span id="L70" rel="#L70">70</span>
<span id="L71" rel="#L71">71</span>
<span id="L72" rel="#L72">72</span>
<span id="L73" rel="#L73">73</span>
<span id="L74" rel="#L74">74</span>
<span id="L75" rel="#L75">75</span>
<span id="L76" rel="#L76">76</span>
<span id="L77" rel="#L77">77</span>
<span id="L78" rel="#L78">78</span>
<span id="L79" rel="#L79">79</span>
<span id="L80" rel="#L80">80</span>
<span id="L81" rel="#L81">81</span>
<span id="L82" rel="#L82">82</span>
<span id="L83" rel="#L83">83</span>
<span id="L84" rel="#L84">84</span>
<span id="L85" rel="#L85">85</span>
<span id="L86" rel="#L86">86</span>
<span id="L87" rel="#L87">87</span>
<span id="L88" rel="#L88">88</span>
<span id="L89" rel="#L89">89</span>
<span id="L90" rel="#L90">90</span>
<span id="L91" rel="#L91">91</span>
<span id="L92" rel="#L92">92</span>
<span id="L93" rel="#L93">93</span>
<span id="L94" rel="#L94">94</span>
<span id="L95" rel="#L95">95</span>
<span id="L96" rel="#L96">96</span>
<span id="L97" rel="#L97">97</span>
<span id="L98" rel="#L98">98</span>
<span id="L99" rel="#L99">99</span>
<span id="L100" rel="#L100">100</span>
<span id="L101" rel="#L101">101</span>
<span id="L102" rel="#L102">102</span>
<span id="L103" rel="#L103">103</span>
<span id="L104" rel="#L104">104</span>
<span id="L105" rel="#L105">105</span>
<span id="L106" rel="#L106">106</span>
<span id="L107" rel="#L107">107</span>
<span id="L108" rel="#L108">108</span>
<span id="L109" rel="#L109">109</span>
<span id="L110" rel="#L110">110</span>
<span id="L111" rel="#L111">111</span>
<span id="L112" rel="#L112">112</span>
<span id="L113" rel="#L113">113</span>
<span id="L114" rel="#L114">114</span>
<span id="L115" rel="#L115">115</span>
<span id="L116" rel="#L116">116</span>
<span id="L117" rel="#L117">117</span>
<span id="L118" rel="#L118">118</span>
<span id="L119" rel="#L119">119</span>
<span id="L120" rel="#L120">120</span>
<span id="L121" rel="#L121">121</span>
<span id="L122" rel="#L122">122</span>
<span id="L123" rel="#L123">123</span>
<span id="L124" rel="#L124">124</span>
<span id="L125" rel="#L125">125</span>
<span id="L126" rel="#L126">126</span>
<span id="L127" rel="#L127">127</span>
<span id="L128" rel="#L128">128</span>
<span id="L129" rel="#L129">129</span>
<span id="L130" rel="#L130">130</span>
<span id="L131" rel="#L131">131</span>
<span id="L132" rel="#L132">132</span>
<span id="L133" rel="#L133">133</span>
<span id="L134" rel="#L134">134</span>
<span id="L135" rel="#L135">135</span>
<span id="L136" rel="#L136">136</span>
<span id="L137" rel="#L137">137</span>
<span id="L138" rel="#L138">138</span>
<span id="L139" rel="#L139">139</span>
<span id="L140" rel="#L140">140</span>
<span id="L141" rel="#L141">141</span>
<span id="L142" rel="#L142">142</span>
<span id="L143" rel="#L143">143</span>
<span id="L144" rel="#L144">144</span>
<span id="L145" rel="#L145">145</span>
<span id="L146" rel="#L146">146</span>
<span id="L147" rel="#L147">147</span>
<span id="L148" rel="#L148">148</span>
<span id="L149" rel="#L149">149</span>
<span id="L150" rel="#L150">150</span>
<span id="L151" rel="#L151">151</span>
<span id="L152" rel="#L152">152</span>
<span id="L153" rel="#L153">153</span>
<span id="L154" rel="#L154">154</span>
<span id="L155" rel="#L155">155</span>
<span id="L156" rel="#L156">156</span>
<span id="L157" rel="#L157">157</span>
<span id="L158" rel="#L158">158</span>
<span id="L159" rel="#L159">159</span>
<span id="L160" rel="#L160">160</span>
<span id="L161" rel="#L161">161</span>
<span id="L162" rel="#L162">162</span>
<span id="L163" rel="#L163">163</span>
<span id="L164" rel="#L164">164</span>
<span id="L165" rel="#L165">165</span>

           </td>
           <td class="blob-line-code"><div class="code-body highlight"><pre><div class='line' id='LC1'><span class="c1"># Pageless Redirect Generator</span></div><div class='line' id='LC2'><span class="c1">#</span></div><div class='line' id='LC3'><span class="c1"># Generates redirect pages based on YAML or htaccess style redirects</span></div><div class='line' id='LC4'><span class="c1">#</span></div><div class='line' id='LC5'><span class="c1"># To generate redirects create _redirects.yml, _redirects.htaccess, and/or _redirects.json in the Jekyll root directory</span></div><div class='line' id='LC6'><span class="c1"># both follow the pattern alias, final destination.</span></div><div class='line' id='LC7'><span class="c1">#</span></div><div class='line' id='LC8'><span class="c1"># Example _redirects.yml</span></div><div class='line' id='LC9'><span class="c1">#</span></div><div class='line' id='LC10'><span class="c1">#   initial-page   : /destination-page</span></div><div class='line' id='LC11'><span class="c1">#   other-page     : http://example.org/destination-page</span></div><div class='line' id='LC12'><span class="c1">#   &quot;another/page&quot; : /destination-page</span></div><div class='line' id='LC13'><span class="c1">#</span></div><div class='line' id='LC14'><span class="c1">#  Result:</span></div><div class='line' id='LC15'><span class="c1">#   Requests to /initial-page are redirected to /destination-page</span></div><div class='line' id='LC16'><span class="c1">#   Requests to /other-page are redirected to http://example.org/destination-page</span></div><div class='line' id='LC17'><span class="c1">#   Requests to /another/page are redirected to /destination-page</span></div><div class='line' id='LC18'><span class="c1">#</span></div><div class='line' id='LC19'><span class="c1">#</span></div><div class='line' id='LC20'><span class="c1"># Example _redirects.htaccess</span></div><div class='line' id='LC21'><span class="c1">#</span></div><div class='line' id='LC22'><span class="c1">#   Redirect /some-page /destination-page</span></div><div class='line' id='LC23'><span class="c1">#   Redirect 301 /different-page /destination-page</span></div><div class='line' id='LC24'><span class="c1">#   Redirect cool-page http://example.org/destination-page</span></div><div class='line' id='LC25'><span class="c1">#</span></div><div class='line' id='LC26'><span class="c1">#  Result:</span></div><div class='line' id='LC27'><span class="c1">#   Requests to /some-page are redirected to /destination-page</span></div><div class='line' id='LC28'><span class="c1">#   Requests to /different-page are redirected to /destination-page</span></div><div class='line' id='LC29'><span class="c1">#   Requests to /cool-page are redirected to http://example.org/destination-page</span></div><div class='line' id='LC30'><span class="c1">#</span></div><div class='line' id='LC31'><span class="c1">#</span></div><div class='line' id='LC32'><span class="c1"># Example _redirects.json</span></div><div class='line' id='LC33'><span class="c1">#</span></div><div class='line' id='LC34'><span class="c1">#   {</span></div><div class='line' id='LC35'><span class="c1">#     &quot;some-page&quot;        : &quot;/destination-page&quot;,</span></div><div class='line' id='LC36'><span class="c1">#     &quot;yet-another-page&quot; : &quot;http://example.org/destination-page&quot;,</span></div><div class='line' id='LC37'><span class="c1">#     &quot;ninth-page&quot;       : &quot;/destination-page&quot;</span></div><div class='line' id='LC38'><span class="c1">#   }</span></div><div class='line' id='LC39'><span class="c1">#</span></div><div class='line' id='LC40'><span class="c1">#  Result:</span></div><div class='line' id='LC41'><span class="c1">#   Requests to /some-page are redirected to /destination-page</span></div><div class='line' id='LC42'><span class="c1">#   Requests to /yet-another-page are redirected to http://example.org/destination-page</span></div><div class='line' id='LC43'><span class="c1">#   Requests to /ninth-page are redirected to /destination-page</span></div><div class='line' id='LC44'><span class="c1">#</span></div><div class='line' id='LC45'><span class="c1">#</span></div><div class='line' id='LC46'><span class="c1"># Author: Nick Quinlan</span></div><div class='line' id='LC47'><span class="c1"># Site: http://nicholasquinlan.com</span></div><div class='line' id='LC48'><span class="c1"># Plugin Source: https://github.com/nquinlan/jekyll-pageless-redirects</span></div><div class='line' id='LC49'><span class="c1"># Plugin License: MIT</span></div><div class='line' id='LC50'><span class="c1"># Plugin Credit: This plugin borrows heavily from alias_generator (http://github.com/tsmango/jekyll_alias_generator) by Thomas Mango (http://thomasmango.com)</span></div><div class='line' id='LC51'><br/></div><div class='line' id='LC52'><span class="nb">require</span> <span class="s1">&#39;json&#39;</span></div><div class='line' id='LC53'><br/></div><div class='line' id='LC54'><span class="k">module</span> <span class="nn">Jekyll</span></div><div class='line' id='LC55'><br/></div><div class='line' id='LC56'>&nbsp;&nbsp;<span class="k">class</span> <span class="nc">PagelessRedirectGenerator</span> <span class="o">&lt;</span> <span class="no">Generator</span></div><div class='line' id='LC57'><br/></div><div class='line' id='LC58'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">def</span> <span class="nf">generate</span><span class="p">(</span><span class="n">site</span><span class="p">)</span></div><div class='line' id='LC59'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="vi">@site</span> <span class="o">=</span> <span class="n">site</span></div><div class='line' id='LC60'><br/></div><div class='line' id='LC61'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">process_yaml</span></div><div class='line' id='LC62'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">process_htaccess</span></div><div class='line' id='LC63'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">process_json</span></div><div class='line' id='LC64'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC65'><br/></div><div class='line' id='LC66'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">def</span> <span class="nf">process_yaml</span></div><div class='line' id='LC67'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">file_path</span> <span class="o">=</span> <span class="vi">@site</span><span class="o">.</span><span class="n">source</span> <span class="o">+</span> <span class="s2">&quot;/_redirects.yml&quot;</span></div><div class='line' id='LC68'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> <span class="no">File</span><span class="o">.</span><span class="n">exists?</span><span class="p">(</span><span class="n">file_path</span><span class="p">)</span></div><div class='line' id='LC69'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="no">YAML</span><span class="o">.</span><span class="n">load_file</span><span class="p">(</span><span class="n">file_path</span><span class="p">,</span> <span class="ss">:safe</span> <span class="o">=&gt;</span> <span class="kp">true</span><span class="p">)</span><span class="o">.</span><span class="n">each</span> <span class="k">do</span> <span class="o">|</span> <span class="n">new_url</span><span class="p">,</span> <span class="n">old_url</span> <span class="o">|</span></div><div class='line' id='LC70'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">generate_aliases</span><span class="p">(</span> <span class="n">old_url</span><span class="p">,</span> <span class="n">new_url</span> <span class="p">)</span></div><div class='line' id='LC71'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC72'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC73'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC74'><br/></div><div class='line' id='LC75'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">def</span> <span class="nf">process_htaccess</span></div><div class='line' id='LC76'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">file_path</span> <span class="o">=</span> <span class="vi">@site</span><span class="o">.</span><span class="n">source</span> <span class="o">+</span> <span class="s2">&quot;/_redirects.htaccess&quot;</span></div><div class='line' id='LC77'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> <span class="no">File</span><span class="o">.</span><span class="n">exists?</span><span class="p">(</span><span class="n">file_path</span><span class="p">)</span></div><div class='line' id='LC78'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="c1"># Read the file line by line pushing redirects to the redirects array</span></div><div class='line' id='LC79'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">file</span> <span class="o">=</span> <span class="no">File</span><span class="o">.</span><span class="n">new</span><span class="p">(</span><span class="n">file_path</span><span class="p">,</span> <span class="s2">&quot;r&quot;</span><span class="p">)</span></div><div class='line' id='LC80'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">while</span> <span class="p">(</span><span class="n">line</span> <span class="o">=</span> <span class="n">file</span><span class="o">.</span><span class="n">gets</span><span class="p">)</span></div><div class='line' id='LC81'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="c1"># Match the line against a regex, if it matches push it to the object</span></div><div class='line' id='LC82'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="sr">/^Redirect(\s+30[1237])?\s+(.+?)\s+(.+?)$/</span><span class="o">.</span><span class="n">match</span><span class="p">(</span><span class="n">line</span><span class="p">)</span> <span class="p">{</span> <span class="o">|</span> <span class="n">matches</span> <span class="o">|</span></div><div class='line' id='LC83'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">generate_aliases</span><span class="p">(</span> <span class="n">matches</span><span class="o">[</span><span class="mi">3</span><span class="o">]</span><span class="p">,</span> <span class="n">matches</span><span class="o">[</span><span class="mi">2</span><span class="o">]</span><span class="p">)</span></div><div class='line' id='LC84'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">}</span></div><div class='line' id='LC85'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC86'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">file</span><span class="o">.</span><span class="n">close</span></div><div class='line' id='LC87'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC88'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC89'><br/></div><div class='line' id='LC90'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">def</span> <span class="nf">process_json</span></div><div class='line' id='LC91'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">file_path</span> <span class="o">=</span> <span class="vi">@site</span><span class="o">.</span><span class="n">source</span> <span class="o">+</span> <span class="s2">&quot;/_redirects.json&quot;</span></div><div class='line' id='LC92'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> <span class="no">File</span><span class="o">.</span><span class="n">exists?</span><span class="p">(</span><span class="n">file_path</span><span class="p">)</span></div><div class='line' id='LC93'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">file</span> <span class="o">=</span> <span class="no">File</span><span class="o">.</span><span class="n">new</span><span class="p">(</span><span class="n">file_path</span><span class="p">,</span> <span class="s2">&quot;r&quot;</span><span class="p">)</span></div><div class='line' id='LC94'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">content</span> <span class="o">=</span> <span class="no">JSON</span><span class="o">.</span><span class="n">parse</span><span class="p">(</span><span class="n">file</span><span class="o">.</span><span class="n">read</span><span class="p">)</span></div><div class='line' id='LC95'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">content</span><span class="o">.</span><span class="n">each</span> <span class="k">do</span> <span class="o">|</span><span class="n">new_url</span><span class="p">,</span> <span class="n">old_url</span><span class="o">|</span></div><div class='line' id='LC96'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">generate_aliases</span><span class="p">(</span><span class="n">old_url</span><span class="p">,</span> <span class="n">new_url</span><span class="p">)</span></div><div class='line' id='LC97'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC98'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">file</span><span class="o">.</span><span class="n">close</span></div><div class='line' id='LC99'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC100'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC101'><br/></div><div class='line' id='LC102'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">def</span> <span class="nf">generate_aliases</span><span class="p">(</span><span class="n">destination_path</span><span class="p">,</span> <span class="n">aliases</span><span class="p">)</span></div><div class='line' id='LC103'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">alias_paths</span> <span class="o">||=</span> <span class="nb">Array</span><span class="o">.</span><span class="n">new</span></div><div class='line' id='LC104'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">alias_paths</span> <span class="o">&lt;&lt;</span> <span class="n">aliases</span></div><div class='line' id='LC105'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">alias_paths</span><span class="o">.</span><span class="n">compact!</span></div><div class='line' id='LC106'><br/></div><div class='line' id='LC107'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">alias_paths</span><span class="o">.</span><span class="n">flatten</span><span class="o">.</span><span class="n">each</span> <span class="k">do</span> <span class="o">|</span><span class="n">alias_path</span><span class="o">|</span></div><div class='line' id='LC108'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">alias_path</span> <span class="o">=</span> <span class="n">alias_path</span><span class="o">.</span><span class="n">to_s</span></div><div class='line' id='LC109'><br/></div><div class='line' id='LC110'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">alias_dir</span>  <span class="o">=</span> <span class="no">File</span><span class="o">.</span><span class="n">extname</span><span class="p">(</span><span class="n">alias_path</span><span class="p">)</span><span class="o">.</span><span class="n">empty?</span> <span class="p">?</span> <span class="n">alias_path</span> <span class="p">:</span> <span class="no">File</span><span class="o">.</span><span class="n">dirname</span><span class="p">(</span><span class="n">alias_path</span><span class="p">)</span></div><div class='line' id='LC111'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">alias_file</span> <span class="o">=</span> <span class="no">File</span><span class="o">.</span><span class="n">extname</span><span class="p">(</span><span class="n">alias_path</span><span class="p">)</span><span class="o">.</span><span class="n">empty?</span> <span class="p">?</span> <span class="s2">&quot;index.html&quot;</span> <span class="p">:</span> <span class="no">File</span><span class="o">.</span><span class="n">basename</span><span class="p">(</span><span class="n">alias_path</span><span class="p">)</span></div><div class='line' id='LC112'><br/></div><div class='line' id='LC113'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">fs_path_to_dir</span>   <span class="o">=</span> <span class="no">File</span><span class="o">.</span><span class="n">join</span><span class="p">(</span><span class="vi">@site</span><span class="o">.</span><span class="n">dest</span><span class="p">,</span> <span class="n">alias_dir</span><span class="p">)</span></div><div class='line' id='LC114'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">alias_index_path</span> <span class="o">=</span> <span class="no">File</span><span class="o">.</span><span class="n">join</span><span class="p">(</span><span class="n">alias_dir</span><span class="p">,</span> <span class="n">alias_file</span><span class="p">)</span></div><div class='line' id='LC115'><br/></div><div class='line' id='LC116'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="no">FileUtils</span><span class="o">.</span><span class="n">mkdir_p</span><span class="p">(</span><span class="n">fs_path_to_dir</span><span class="p">)</span></div><div class='line' id='LC117'><br/></div><div class='line' id='LC118'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="no">File</span><span class="o">.</span><span class="n">open</span><span class="p">(</span><span class="no">File</span><span class="o">.</span><span class="n">join</span><span class="p">(</span><span class="n">fs_path_to_dir</span><span class="p">,</span> <span class="n">alias_file</span><span class="p">),</span> <span class="s1">&#39;w&#39;</span><span class="p">)</span> <span class="k">do</span> <span class="o">|</span><span class="n">file</span><span class="o">|</span></div><div class='line' id='LC119'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">file</span><span class="o">.</span><span class="n">write</span><span class="p">(</span><span class="n">alias_template</span><span class="p">(</span><span class="n">destination_path</span><span class="p">))</span></div><div class='line' id='LC120'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC121'><br/></div><div class='line' id='LC122'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="n">alias_index_path</span><span class="o">.</span><span class="n">split</span><span class="p">(</span><span class="s1">&#39;/&#39;</span><span class="p">)</span><span class="o">.</span><span class="n">size</span> <span class="o">+</span> <span class="mi">1</span><span class="p">)</span><span class="o">.</span><span class="n">times</span> <span class="k">do</span> <span class="o">|</span><span class="n">sections</span><span class="o">|</span></div><div class='line' id='LC123'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="vi">@site</span><span class="o">.</span><span class="n">static_files</span> <span class="o">&lt;&lt;</span> <span class="no">Jekyll</span><span class="o">::</span><span class="no">PagelessRedirectFile</span><span class="o">.</span><span class="n">new</span><span class="p">(</span><span class="vi">@site</span><span class="p">,</span> <span class="vi">@site</span><span class="o">.</span><span class="n">dest</span><span class="p">,</span> <span class="n">alias_index_path</span><span class="o">.</span><span class="n">split</span><span class="p">(</span><span class="s1">&#39;/&#39;</span><span class="p">)</span><span class="o">[</span><span class="mi">0</span><span class="p">,</span> <span class="n">sections</span><span class="o">].</span><span class="n">join</span><span class="p">(</span><span class="s1">&#39;/&#39;</span><span class="p">),</span> <span class="s1">&#39;&#39;</span><span class="p">)</span></div><div class='line' id='LC124'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC125'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC126'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC127'><br/></div><div class='line' id='LC128'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">def</span> <span class="nf">alias_template</span><span class="p">(</span><span class="n">destination_path</span><span class="p">)</span></div><div class='line' id='LC129'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="o">&lt;&lt;-</span><span class="no">EOF</span></div><div class='line' id='LC130'><span class="sh">      &lt;!DOCTYPE html&gt;</span></div><div class='line' id='LC131'><span class="sh">      &lt;html&gt;</span></div><div class='line' id='LC132'><span class="sh">      &lt;head&gt;</span></div><div class='line' id='LC133'><span class="sh">      &lt;title&gt;Redirecting...&lt;/title&gt;</span></div><div class='line' id='LC134'><span class="sh">      &lt;link rel=&quot;canonical&quot; href=&quot;#{destination_path}&quot;/&gt;</span></div><div class='line' id='LC135'><span class="sh">      &lt;meta http-equiv=&quot;content-type&quot; content=&quot;text/html; charset=utf-8&quot; /&gt;</span></div><div class='line' id='LC136'><span class="sh">      &lt;meta http-equiv=&quot;refresh&quot; content=&quot;0; url=#{destination_path}&quot; /&gt;</span></div><div class='line' id='LC137'><span class="sh">      &lt;/head&gt;</span></div><div class='line' id='LC138'><span class="sh">      &lt;body&gt;</span></div><div class='line' id='LC139'><span class="sh">        &lt;p&gt;&lt;strong&gt;Redirecting...&lt;/strong&gt;&lt;/p&gt;</span></div><div class='line' id='LC140'><span class="sh">        &lt;p&gt;&lt;a href=&#39;#{destination_path}&#39;&gt;Click here if you are not redirected.&lt;/a&gt;&lt;/p&gt;</span></div><div class='line' id='LC141'><span class="sh">        &lt;script&gt;</span></div><div class='line' id='LC142'><span class="sh">          document.location.href = &quot;#{destination_path}&quot;;</span></div><div class='line' id='LC143'><span class="sh">        &lt;/script&gt;</span></div><div class='line' id='LC144'><span class="sh">      &lt;/body&gt;</span></div><div class='line' id='LC145'><span class="sh">      &lt;/html&gt;</span></div><div class='line' id='LC146'><span class="no">      EOF</span></div><div class='line' id='LC147'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC148'>&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC149'><br/></div><div class='line' id='LC150'>&nbsp;&nbsp;<span class="k">class</span> <span class="nc">PagelessRedirectFile</span> <span class="o">&lt;</span> <span class="no">StaticFile</span></div><div class='line' id='LC151'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="nb">require</span> <span class="s1">&#39;set&#39;</span></div><div class='line' id='LC152'><br/></div><div class='line' id='LC153'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">def</span> <span class="nf">destination</span><span class="p">(</span><span class="n">dest</span><span class="p">)</span></div><div class='line' id='LC154'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="no">File</span><span class="o">.</span><span class="n">join</span><span class="p">(</span><span class="n">dest</span><span class="p">,</span> <span class="vi">@dir</span><span class="p">)</span></div><div class='line' id='LC155'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC156'><br/></div><div class='line' id='LC157'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">def</span> <span class="nf">modified?</span></div><div class='line' id='LC158'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">return</span> <span class="kp">false</span></div><div class='line' id='LC159'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC160'><br/></div><div class='line' id='LC161'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">def</span> <span class="nf">write</span><span class="p">(</span><span class="n">dest</span><span class="p">)</span></div><div class='line' id='LC162'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">return</span> <span class="kp">true</span></div><div class='line' id='LC163'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC164'>&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC165'><span class="k">end</span></div></pre></div></td>
         </tr>
       </table>
  </div>

  </div>
</div>

<a href="#jump-to-line" rel="facebox[.linejump]" data-hotkey="l" class="js-jump-to-line" style="display:none">Jump to Line</a>
<div id="jump-to-line" style="display:none">
  <form accept-charset="UTF-8" class="js-jump-to-line-form">
    <input class="linejump-input js-jump-to-line-field" type="text" placeholder="Jump to line&hellip;" autofocus>
    <button type="submit" class="button">Go</button>
  </form>
</div>

        </div>

      </div><!-- /.repo-container -->
      <div class="modal-backdrop"></div>
    </div><!-- /.container -->
  </div><!-- /.site -->


    </div><!-- /.wrapper -->

      <div class="container">
  <div class="site-footer">
    <ul class="site-footer-links right">
      <li><a href="https://status.github.com/">Status</a></li>
      <li><a href="http://developer.github.com">API</a></li>
      <li><a href="http://training.github.com">Training</a></li>
      <li><a href="http://shop.github.com">Shop</a></li>
      <li><a href="/blog">Blog</a></li>
      <li><a href="/about">About</a></li>

    </ul>

    <a href="/" aria-label="Homepage">
      <span class="mega-octicon octicon-mark-github" title="GitHub"></span>
    </a>

    <ul class="site-footer-links">
      <li>&copy; 2014 <span title="0.02358s from github-fe125-cp1-prd.iad.github.net">GitHub</span>, Inc.</li>
        <li><a href="/site/terms">Terms</a></li>
        <li><a href="/site/privacy">Privacy</a></li>
        <li><a href="/security">Security</a></li>
        <li><a href="/contact">Contact</a></li>
    </ul>
  </div><!-- /.site-footer -->
</div><!-- /.container -->


    <div class="fullscreen-overlay js-fullscreen-overlay" id="fullscreen_overlay">
  <div class="fullscreen-container js-fullscreen-container">
    <div class="textarea-wrap">
      <textarea name="fullscreen-contents" id="fullscreen-contents" class="fullscreen-contents js-fullscreen-contents" placeholder="" data-suggester="fullscreen_suggester"></textarea>
    </div>
  </div>
  <div class="fullscreen-sidebar">
    <a href="#" class="exit-fullscreen js-exit-fullscreen tooltipped tooltipped-w" aria-label="Exit Zen Mode">
      <span class="mega-octicon octicon-screen-normal"></span>
    </a>
    <a href="#" class="theme-switcher js-theme-switcher tooltipped tooltipped-w"
      aria-label="Switch themes">
      <span class="octicon octicon-color-mode"></span>
    </a>
  </div>
</div>



    <div id="ajax-error-message" class="flash flash-error">
      <span class="octicon octicon-alert"></span>
      <a href="#" class="octicon octicon-x close js-ajax-error-dismiss" aria-label="Dismiss error"></a>
      Something went wrong with that request. Please try again.
    </div>


      <script crossorigin="anonymous" src="https://assets-cdn.github.com/assets/frameworks-16cc79824e99a0bd7ee02ebeac9f0ba7d1116bef.js" type="text/javascript"></script>
      <script async="async" crossorigin="anonymous" src="https://assets-cdn.github.com/assets/github-793f80c2bb36b2b60a93b4f1bb1256051e261a26.js" type="text/javascript"></script>
      
      
        <script async src="https://www.google-analytics.com/analytics.js"></script>
  </body>
</html>

