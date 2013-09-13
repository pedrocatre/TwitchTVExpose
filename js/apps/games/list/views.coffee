define ['apps/games/list/templates', 'views/_base', 'msgbus'], (Templates, AppView, msgBus) ->

    class GameItem extends AppView.ItemView
        template: _.template(Templates.gameitem)
        tagName: "li"
        className: "col-lg-3 col-md-4 col-sm-6 col-xs-12"
        triggers:
            "click" : "game:item:clicked"

    TopGameList: class TopGameList extends AppView.CompositeView
        template: _.template(Templates.topgame)
        itemView: GameItem
        itemViewContainer: "#items"
        events: 
            'scroll': 'checkScroll'

        checkScroll: ->
            triggerPoint = 100 #100px from the bottom
            if @el.scrollTop + @el.clientHeight + triggerPoint > @el.scrollHeight
                @collection.offset += 1 #Load next page
                msgBus.events.trigger "games:fetchmore", @collection.offset



    Hero: class Hero extends AppView.ItemView
        template: _.template(Templates.hero)

    Layout: class GamesLayout extends AppView.Layout
        template: _.template(Templates.layout)
        regions:
            gameRegion:  "#game-region"
            streamRegion:   "#stream-region"