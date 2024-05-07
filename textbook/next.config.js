const withMarkdoc = require('@markdoc/next.js')

/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  pageExtensions: ['js', 'jsx', 'md'],
  experimental: {
    scrollRestoration: true,
  },
  images: {
    unoptimized: true,
  },
  // VPSの場合は、こちらを使う
  //basePath: '/textbook', 
  trailingSlash: true,

  /**
  publicRuntimeConfig: '/textbook', 
  assetPrefix: '/textbook',
 */
}

module.exports = withMarkdoc()(nextConfig)
