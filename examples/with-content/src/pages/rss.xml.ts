import rss from '@astrojs/rss';
import { getCollection } from 'astro:content';

export async function get() {
	const blog = await getCollection('blog');
	return rss({
		title: 'My Astro Site',
		description: 'My Astro Site Description',
		site: 'https://example.com',
		items: blog.map((item) => ({ ...item.data, link: `/blog/${item.slug}/` })),
	});
}
