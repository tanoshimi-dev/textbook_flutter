import Head from 'next/head'
import { useRouter } from 'next/router'

import { slugifyWithCounter } from '@sindresorhus/slugify'

import { Layout } from '@/components/Layout'
import { LayoutNotAuthenticated } from '@/components/LayoutNotAuthenticated'
import { LayoutWeb } from '@/components/LayoutWeb'
import { LayoutWebAdv } from '@/components/LayoutWebAdv'
import { LayoutWp } from '@/components/LayoutWp'
import { LayoutPg } from '@/components/LayoutPg'
import { LayoutWebSys } from '@/components/LayoutWebSys'
import { LayoutFlutter1 } from '@/components/LayoutFlutter1'
import { LayoutFlutter2 } from '@/components/LayoutFlutter2'
import { LayoutVuejs } from '@/components/LayoutVuejs'
import { LayoutDocker } from '@/components/LayoutDocker'
import { LayoutPhp } from '@/components/LayoutPhp'
import { LayoutTypeScript } from '@/components/LayoutTypeScript'
import { LayoutNodejs } from '@/components/LayoutNodejs'
import { LayoutDevops } from '@/components/LayoutDevops'

import 'focus-visible'
import '@/styles/tailwind.css'
import '@/styles/custom.css'

function getNodeText(node) {
  let text = ''
  for (let child of node.children ?? []) {
    if (typeof child === 'string') {
      text += child
    }
    text += getNodeText(child)
  }
  return text
}

function collectHeadings(nodes, slugify = slugifyWithCounter()) {
  let sections = []

  for (let node of nodes) {
    if (node.name === 'h2' || node.name === 'h3') {
      let title = getNodeText(node)
      if (title) {
        let id = slugify(title)
        node.attributes.id = id
        if (node.name === 'h3') {
          if (!sections[sections.length - 1]) {
            throw new Error(
              'Cannot add `h3` to table of contents without a preceding `h2`'
            )
          }
          sections[sections.length - 1].children.push({
            ...node.attributes,
            title,
          })
        } else {
          sections.push({ ...node.attributes, title, children: [] })
        }
      }
    }

    sections.push(...collectHeadings(node.children ?? [], slugify))
  }

  return sections
}


export default function App({ Component, pageProps }) {

  //console.log('★★★ router ★★★',router)

  let title = pageProps.markdoc?.frontmatter.title
  

  const LAYOUT_DEFAULT = 'index';
  const LAYOUT_WEB = 2;
  const LAYOUT_WEBADV = 21;
  const LAYOUT_WP = 3;
  const LAYOUT_PG = 4;
  const LAYOUT_WEBSYS = 6;
  const LAYOUT_FLUTTER_1 = 'Flutter1';
  const LAYOUT_FLUTTER_2 = 'Flutter2';
  const LAYOUT_VUEJS = 'vuejs';
  const LAYOUT_DOCKER = 'docker';
  const LAYOUT_PHP = 'php';
  const LAYOUT_NODEJS = 'nodejs';
  const LAYOUT_TYPESCRIPT = 'typescript';
  const LAYOUT_DEVOPS = 'devops';

  let layoutId = LAYOUT_DEFAULT;
  let currentPath = pageProps.markdoc?.file.path;
  let pageTitle =
  pageProps.markdoc?.frontmatter.pageTitle ||
  `${pageProps.markdoc?.frontmatter.title} - Docs`
  
  if(currentPath != undefined) {

    // console.log('currentPath',currentPath);
    // console.log('\docs\pg\web-basic-1.md','\/docs\/pg\/web-basic-1.md'.length);
    // console.log('currentPath.length',currentPath.length);

    // console.log('startsWith=', ('\/docs\/pg\/web-basic-1.md'.startsWith('\/docs\/pg')))
    // console.log('startsWith=', (currentPath.startsWith('\\docs\\pg')))

    if (currentPath.startsWith('\\docs\\webadv')){
      layoutId = LAYOUT_WEBADV;
      pageTitle = 'Web応用';

    } else if(currentPath.startsWith('\\docs\\websys')){
      layoutId = LAYOUT_WEBSYS;
      pageTitle = 'システム開発';
  
    } else if(currentPath.startsWith('\\docs\\web')){
      layoutId = LAYOUT_WEB;
      pageTitle = 'Web基礎';

    
    } else if(currentPath.startsWith('\\docs\\wp')){
      layoutId = LAYOUT_WP;
      pageTitle = 'WordPress';

    } else if(currentPath.startsWith('\\docs\\pg')){
      layoutId = LAYOUT_PG;
      pageTitle = 'プログラミング';

    } else if(currentPath.startsWith('\\docs\\flutter1')){
      layoutId = LAYOUT_FLUTTER_1;
      pageTitle = 'Flutter 1';
  
    } else if(currentPath.startsWith('\\docs\\flutter2')){
      layoutId = LAYOUT_FLUTTER_2;
      pageTitle = 'Flutter 2';
  
    } else if(currentPath.startsWith('\\docs\\vuejs')){
      layoutId = LAYOUT_VUEJS;
      pageTitle = 'Vue.js';
  
    } else if(currentPath.startsWith('\\docs\\docker')){
      layoutId = LAYOUT_DOCKER;
      pageTitle = 'Docker';

    } else if(currentPath.startsWith('\\docs\\php')){
      layoutId = LAYOUT_PHP;
      pageTitle = 'PHP';

    } else if(currentPath.startsWith('\\docs\\nodejs')){
      layoutId = LAYOUT_NODEJS;
      pageTitle = 'Node.js';

    } else if(currentPath.startsWith('\\docs\\typescript')){
      layoutId = LAYOUT_TYPESCRIPT;
      pageTitle = 'TypeScript';

    } else if(currentPath.startsWith('\\docs\\devops')){
      layoutId = LAYOUT_DEVOPS;
      pageTitle = 'Devops';

    } 

    
    // console.log(layoutId);
      
  }





  // let authenticated = false;
  // if('サンプル guide - Docs' == pageTitle){
  //   console.log("権限無し");
  //   authenticated = false;

  // } else {
  //   console.log("通常遷移",pageTitle);
  //   authenticated = true;
  // }

  let description = pageProps.markdoc?.frontmatter.description

  //右側のTOC
  let tableOfContents = pageProps.markdoc?.content
    ? collectHeadings(pageProps.markdoc.content)
    : []

  // console.log('★★★ App [markdoc] ★★★',pageProps.markdoc)
  // console.log('★★★ App [pageProps] ★★★',pageProps)
  // console.log('★★★ App [pageProps.markdoc.file.path] ★★★',pageProps.markdoc?.file.path)

  return (
    <>
      <Head>
        <title>{pageTitle}</title>
        {description && <meta name="description" content={description} />}
      </Head>
      
      { (layoutId === LAYOUT_DEFAULT) &&
         (<Layout title={title} tableOfContents={tableOfContents}>
            <Component {...pageProps} />
          </Layout>)
       }

      { (layoutId === LAYOUT_WEB) &&
         (<LayoutWeb title={title} tableOfContents={tableOfContents}>
            <Component {...pageProps} />
          </LayoutWeb>)
       }

      { (layoutId === LAYOUT_WEBADV) &&
         (<LayoutWebAdv title={title} tableOfContents={tableOfContents}>
            <Component {...pageProps} />
          </LayoutWebAdv>)
       }

      { (layoutId === LAYOUT_WP) &&
         (<LayoutWp title={title} tableOfContents={tableOfContents}>
            <Component {...pageProps} />
          </LayoutWp>)
      }

      { (layoutId === LAYOUT_PG) &&
         (<LayoutPg title={title} tableOfContents={tableOfContents}>
            <Component {...pageProps} />
          </LayoutPg>)
      }

      { (layoutId === LAYOUT_WEBSYS) &&
         (<LayoutWebSys title={title} tableOfContents={tableOfContents}>
            <Component {...pageProps} />
          </LayoutWebSys>)
      }

      { (layoutId === LAYOUT_FLUTTER_1) &&
         (<LayoutFlutter1 title={title} tableOfContents={tableOfContents}>
            <Component {...pageProps} />
          </LayoutFlutter1>)
      }

      { (layoutId === LAYOUT_FLUTTER_2) &&
         (<LayoutFlutter2 title={title} tableOfContents={tableOfContents}>
            <Component {...pageProps} />
          </LayoutFlutter2>)
      }

      { (layoutId === LAYOUT_VUEJS) &&
         (<LayoutVuejs title={title} tableOfContents={tableOfContents}>
            <Component {...pageProps} />
          </LayoutVuejs>)
      }

      { (layoutId === LAYOUT_DOCKER) &&
         (<LayoutDocker title={title} tableOfContents={tableOfContents}>
            <Component {...pageProps} />
          </LayoutDocker>)
      }

      { (layoutId === LAYOUT_PHP) &&
         (<LayoutPhp title={title} tableOfContents={tableOfContents}>
            <Component {...pageProps} />
          </LayoutPhp>)
      }

      { (layoutId === LAYOUT_NODEJS) &&
         (<LayoutNodejs title={title} tableOfContents={tableOfContents}>
            <Component {...pageProps} />
          </LayoutNodejs>)
      }

      { (layoutId === LAYOUT_TYPESCRIPT) &&
         (<LayoutTypeScript title={title} tableOfContents={tableOfContents}>
            <Component {...pageProps} />
          </LayoutTypeScript>)
      }

      { (layoutId === LAYOUT_DEVOPS) &&
         (<LayoutDevops title={title} tableOfContents={tableOfContents}>
            <Component {...pageProps} />
          </LayoutDevops>)
      }

    </>
  )
}
