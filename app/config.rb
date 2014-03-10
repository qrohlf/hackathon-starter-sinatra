# global settings go here
configure do 
    set :app_name, "Hackathon Starter Sinatra"
    set :nav_left, {                                            # Navigation: 
        'Model Example' => '/examples',                          # you can specify the url as a string
        'Payment Example' => '/payment',
        'Icons List' => '/css/vendor/icomoon/font_demo.html',
        'Dropdown' => {                            # or you can pass a hash of other items
            'dropdown item 1' => '#',                           # to create a dropdown
            'dropdown item 2' => '#',
            'dropdown item 3' => '#'
        }
    }
    set :nav_right, {
        'View on Github' => 'https://github.com/qrohlf/hackathon-starter-sinatra'
    }
end
