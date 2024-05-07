import { useCallback, useEffect, useState } from 'react'
import Link from 'next/link'
import { useRouter } from 'next/router'
import clsx from 'clsx'

import { Hero } from '@/components/Hero'
import { Logo, Logomark } from '@/components/Logo'
import { MobileNavigation } from '@/components/MobileNavigation'
import { Navigation } from '@/components/Navigation'
import { Prose } from '@/components/Prose'
import { Search } from '@/components/Search'
import { ThemeSelector } from '@/components/ThemeSelector'
import Image from 'next/image'

const navigation = [
  {
    title: 'ようこそ！',
    links: [
      { title: '概要', href: '/' },
    ],
  },
  {
    title: 'サクッと一気にWeb制作🐶',
    links: [
      { title: 'HTML', href: '/docs/webdev1-html' },
      {
        title: 'CSS',
        href: '/docs/predicting-user-behavior',
      },
      { title: 'JavaScript', href: '/docs/basics-of-time-travel' },
      { title: 'MySQL',href: '/docs/introduction-to-string-theory' },
      { title: 'PHP', href: '/docs/the-butterfly-effect' },
    ],
  },
  {
    title: 'サクッとWordPress',
    links: [
      { title: 'GIMPについて', href: '/docs/writing-plugins' },
      { title: '基本', href: '/docs/neuralink-integration' },
      { title: 'テーマ作成１', href: '/docs/wp/wp-basic-theme1' },
      { title: 'Compile-time caching', href: '/docs/compile-time-caching' },
      {
        title: 'Predictive data generation',
        href: '/docs/predictive-data-generation',
      },
    ],
  },
  {
    title: '無料で画像編集！(GIMP)',
    links: [
      { title: 'GIMPについて', href: '/docs/writing-plugins' },
      { title: 'サイズ変更', href: '/docs/neuralink-integration' },
      { title: 'Temporal paradoxes', href: '/docs/temporal-paradoxes' },
      { title: 'Testing', href: '/docs/testing' },
      { title: 'Compile-time caching', href: '/docs/compile-time-caching' },
      {
        title: 'Predictive data generation',
        href: '/docs/predictive-data-generation',
      },
    ],
  },
  {
    title: '無料でロゴ作成！(Inkscape)',
    links: [
      { title: 'CacheAdvance.predict()', href: '/docs/cacheadvance-predict' },
      { title: 'CacheAdvance.flush()', href: '/docs/cacheadvance-flush' },
      { title: 'CacheAdvance.revert()', href: '/docs/cacheadvance-revert' },
      { title: 'CacheAdvance.regret()', href: '/docs/cacheadvance-regret' },
    ],
  },
  {
    title: '終わりに',
    links: [
      { title: '更に学びたい方', href: '/docs/free/sample-guide' },
    ],
  },
]

function GitHubIcon(props) {
  return (
    <svg aria-hidden="true" viewBox="0 0 16 16" {...props}>
      <path d="M8 0C3.58 0 0 3.58 0 8C0 11.54 2.29 14.53 5.47 15.59C5.87 15.66 6.02 15.42 6.02 15.21C6.02 15.02 6.01 14.39 6.01 13.72C4 14.09 3.48 13.23 3.32 12.78C3.23 12.55 2.84 11.84 2.5 11.65C2.22 11.5 1.82 11.13 2.49 11.12C3.12 11.11 3.57 11.7 3.72 11.94C4.44 13.15 5.59 12.81 6.05 12.6C6.12 12.08 6.33 11.73 6.56 11.53C4.78 11.33 2.92 10.64 2.92 7.58C2.92 6.71 3.23 5.99 3.74 5.43C3.66 5.23 3.38 4.41 3.82 3.31C3.82 3.31 4.49 3.1 6.02 4.13C6.66 3.95 7.34 3.86 8.02 3.86C8.7 3.86 9.38 3.95 10.02 4.13C11.55 3.09 12.22 3.31 12.22 3.31C12.66 4.41 12.38 5.23 12.3 5.43C12.81 5.99 13.12 6.7 13.12 7.58C13.12 10.65 11.25 11.33 9.47 11.53C9.76 11.78 10.01 12.26 10.01 13.01C10.01 14.08 10 14.94 10 15.21C10 15.42 10.15 15.67 10.55 15.59C13.71 14.53 16 11.53 16 8C16 3.58 12.42 0 8 0Z" />
    </svg>
  )
}

function Header({ navigation }) {
  let [isScrolled, setIsScrolled] = useState(false)

  useEffect(() => {
    function onScroll() {
      setIsScrolled(window.scrollY > 0)
    }
    onScroll()
    window.addEventListener('scroll', onScroll, { passive: true })
    return () => {
      window.removeEventListener('scroll', onScroll, { passive: true })
    }
  }, [])

  return (
    <header
      className={clsx(
        'sticky top-0 z-50 flex flex-wrap items-center justify-between bg-white px-4 py-2 shadow-md shadow-slate-900/5 transition duration-500 dark:shadow-none sm:px-6 lg:px-8',
        isScrolled
          ? 'dark:bg-slate-900/95 dark:backdrop-blur dark:[@supports(backdrop-filter:blur(0))]:bg-slate-900/75'
          : 'dark:bg-transparent'
      )}
    >
      <div className="mr-0 flex lg:hidden">
        <MobileNavigation navigation={navigation} />
      </div>

      <div className="relative flex flex-grow basis-0 items-center">
        <Link href="/" aria-label="Home page">
          {/* <Logomark className="h-9 w-9 lg:hidden" />
          <Logo className="hidden h-9 w-auto fill-slate-700 dark:fill-sky-100 lg:block" /> */}

          {/* <div className="grid-element">
            <img src="/textbook/Original on Transparent.png" width="48px" height="48px"
            />
          </div>
 */}
          
          <div className="grid-element">
            <img src="/hannari.dev_logo.png" width="136px" height="48px"
            />
          </div>

          {/* <div className="hidden sm:hidden md:block grid-element">
            <img src="/hannari.dev_logo_small.png" width="48px" height="48px"/>
          </div> */}

          {/* <div className="hidden sm:hidden md:block " style={{ position: 'relative', width: '48px', height: '48px' }}>
            <Image
              src="/Original on Transparent.png"
              fill
              alt="logo"
            />
          </div> */}
{/* 
          <div className="hidden sm:hidden md:block " style={{ position: 'relative', width: '136px', height: '48px' }}>
            <Image
              src="/hannari.dev_logo.png"
              fill
              alt="logo"
            />
          </div>
        */}

        </Link>

      </div>
      <div className="-my-5 mr-6 sm:mr-8 md:mr-0">
        {/* <Search /> */}
      </div>
      <div className="relative flex basis-0 justify-end gap-6 sm:gap-8 md:flex-grow">
        <ThemeSelector className="relative z-10" />
        {/* <Link href="https://github.com" className="group" aria-label="GitHub">
          <GitHubIcon className="h-6 w-6 fill-slate-400 group-hover:fill-slate-500 dark:group-hover:fill-slate-300" />
        </Link> */}
      </div>
    </header>
  )
}

function useTableOfContents(tableOfContents) {
  let [currentSection, setCurrentSection] = useState(tableOfContents[0]?.id)

  let getHeadings = useCallback((tableOfContents) => {
    return tableOfContents
      .flatMap((node) => [node.id, ...node.children.map((child) => child.id)])
      .map((id) => {
        let el = document.getElementById(id)
        if (!el) return

        let style = window.getComputedStyle(el)
        let scrollMt = parseFloat(style.scrollMarginTop)

        let top = window.scrollY + el.getBoundingClientRect().top - scrollMt
        return { id, top }
      })
  }, [])

  useEffect(() => {
    if (tableOfContents.length === 0) return
    let headings = getHeadings(tableOfContents)
    function onScroll() {
      let top = window.scrollY
      let current = headings[0].id
      for (let heading of headings) {
        if (top >= heading.top) {
          current = heading.id
        } else {
          break
        }
      }
      setCurrentSection(current)
    }
    window.addEventListener('scroll', onScroll, { passive: true })
    onScroll()
    return () => {
      window.removeEventListener('scroll', onScroll, { passive: true })
    }
  }, [getHeadings, tableOfContents])

  return currentSection
}

export function Layout({ children, title, tableOfContents }) {
  let router = useRouter()
  let isHomePage = router.pathname === '/'
  let allLinks = navigation.flatMap((section) => section.links)
  let linkIndex = allLinks.findIndex((link) => link.href === router.pathname)
  let previousPage = allLinks[linkIndex - 1]
  let nextPage = allLinks[linkIndex + 1]
  let section = navigation.find((section) =>
    section.links.find((link) => link.href === router.pathname)
  )
  let currentSection = useTableOfContents(tableOfContents)

  // console.log(currentSection)

  function isActive(section) {
    if (section.id === currentSection) {
      //console.log(section.id)
      return true
    }
    if (!section.children) {
      return false
    }
    return section.children.findIndex(isActive) > -1
  }

  return (
    <>
      <Header navigation={navigation} />

      {/* {isHomePage && <Hero />} */}

      {/* <div className="relative mx-auto flex max-w-8xl justify-center sm:px-2 lg:px-16 xl:px-12"> */}
      <div className="relative mx-auto flex max-w-8xl justify-center sm:px-2 lg:px-16 xl:px-12">



        {/* <div className="min-w-0 max-w-2xl flex-auto px-4 py-8 lg:max-w-1/2"> */}
        <div className="min-w-0 max-w-4xl flex-auto px-4 py-8 lg:max-w-1/2">
          <article>
            {(title || section) && (
              <header className="mb-9 space-y-1">
                {section && (
                  // <p className="font-display text-sm font-medium text-sky-500">
                  <p className="font-display text-sm font-medium text-orange-400">
                    {section.title}
                  </p>
                )}
                {title && (
                  <h1 className="font-display text-3xl tracking-tight text-slate-900 dark:text-white">
                    {title}
                  </h1>
                )}
              </header>
            )}
            <Prose>{children}</Prose>
          </article>

        </div>

      </div>
    </>
  )
}
