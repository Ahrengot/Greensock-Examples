FilterRouter = Backbone.Router.extend
	routes: 
		'': 'root', 
		':filter': 'setFilter'
	initialize: -> Backbone.history.start pushState: no
	root: -> $(document).trigger 'gs_update_filter', ['*']
	setFilter: (filter) -> $(document).trigger 'gs_update_filter', [filter]


class Filter
	constructor: () ->
		@items = $ '.gallery .example'
		@filters = $ 'nav.filter li'

		$(document).on 'gs_update_filter', @updateFilter
		@router = new FilterRouter()
		@filters.on 'click a', @handleFilterClick
	handleFilterClick: (e) =>
		filter = $(e.target).data('filter')
		@router.navigate filter, true
	updateFilter: (e, filter) =>
		if filter is '*' then @items.removeClass 'hidden' else @items.each -> $(this).toggleClass 'hidden', !$(this).hasClass(filter)
		@updateFilterNav filter
	updateFilterNav: (filter) ->
		@filters.each ->
			$filter = $(this)
			isCurrentFilter = $filter.find('> a').data('filter') is filter
			$filter.toggleClass 'current', isCurrentFilter



window.Filter = Filter