import Link from 'next/link'

import { Icon } from '@/components/Icon'

export function QuickLinks({ children }) {
  return (
    <div className="not-prose mb-8 grid grid-cols-1 gap-9 sm:grid-cols-2">
      {children}
    </div>
  )
}

export function QuickLink({ title, description, href, icon }) {
  return (
    <div className="group relative rounded-xl border border-slate-200 dark:border-slate-800 h-32 lg:h-36">
      <div className="absolute -inset-px rounded-xl border-2 border-transparent opacity-0 
      [background:linear-gradient(var(--quick-links-hover-bg,theme(colors.yellow.50)),var(--quick-links-hover-bg,theme(colors.orange.50)))_padding-box,linear-gradient(to_top,theme(colors.orange.400),theme(colors.amber.400),theme(colors.yellow.300))_border-box] group-hover:opacity-100 dark:[--quick-links-hover-bg:theme(colors.slate.800)]" />
      <div className="relative overflow-hidden rounded-xl p-6">
        <Link href={href}>

          <div className="flex flex-column">
            <Icon icon={icon} className="h-8 w-8" />
            <span className="pl-4 underline decoration-rose-500 font-bold text-lg">{title}</span>
          </div>

          {/* <h2 className="mt-4 font-display text-base text-slate-900 dark:text-white">
            <Link href={href}>
              <span className="absolute -inset-px rounded-xl" />
              {title}
            </Link>
          </h2> */}

          <p className="mt-1 text-sm text-slate-700 dark:text-slate-400">
            {description}
          </p>
        </Link>
      </div>
    </div>
  )
}
