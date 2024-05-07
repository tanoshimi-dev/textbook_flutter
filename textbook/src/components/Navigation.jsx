import Link from 'next/link'
import { useRouter } from 'next/router'
import clsx from 'clsx'
import { useState, useEffect } from 'react'

export function Navigation({ navigation, className }) {
  let router = useRouter()
  const [subMenuOpen, setSubMenuOpen] = useState({});

  useEffect(() => {
    navigation.map((section, index) => { 
      subMenuOpen[index] = true
    })
    setSubMenuOpen(subMenuOpen)
  }, [])
  
  return (
    <nav className={clsx('text-base lg:text-sm', className)}>
      <ul role="list" className="space-y-9">
        {navigation.map((section, index) => (
          <li key={index}>
            <div 
              className={'flex justify-between items-center cursor-pointer'}
              onClick={()=>{
                setSubMenuOpen({...subMenuOpen, [index]: !subMenuOpen[index]}); 
                }
              } 
            >
              <h2 className="font-display font-medium text-slate-900 dark:text-white">
                {section.title}
              </h2>
              
              { (subMenuOpen[index] === undefined || subMenuOpen[index]) ? 
                <svg 
                  className={`text-slate-600 w-3 h-3`} 
                  xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" d="m19.5 8.25-7.5 7.5-7.5-7.5" />
                </svg>
                :
                <svg 
                  className={`text-slate-600 w-3 h-3`} 
                  xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" >
                  <path strokeLinecap="round" strokeLinejoin="round" d="m4.5 15.75 7.5-7.5 7.5 7.5" />
                </svg>
              }

            </div>
            <ul
              role="list"
              className="mt-2 space-y-2 border-l-2 border-slate-100 dark:border-slate-800 lg:mt-4 lg:space-y-4 lg:border-slate-200"
            >
              { (subMenuOpen[index] === undefined || subMenuOpen[index]) && section.links.map((link) => (
                <li key={link.href} className="relative">
                  <Link
                    href={link.href}
                    className={clsx(
                      'block w-full pl-3.5 before:pointer-events-none before:absolute before:-left-1 before:top-1/2 before:h-1.5 before:w-1.5 before:-translate-y-1/2 before:rounded-full',
                      link.href === router.pathname
                      // ? 'font-semibold text-sky-500 before:bg-sky-500'
                        ? 'font-semibold text-orange-400 before:bg-orange-500'
                        : 'text-slate-500 before:hidden before:bg-slate-300 hover:text-slate-600 hover:before:block dark:text-slate-400 dark:before:bg-slate-700 dark:hover:text-slate-300'
                    )}
                  >
                    {link.title}
                  </Link>
                </li>
              ))}
            </ul>
          </li>
        ))}
      </ul>
    </nav>
  )
}
