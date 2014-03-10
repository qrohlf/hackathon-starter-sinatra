# global settings go here
configure do 
    set :app_name, "Hackathon Starter Sinatra"
    # Navigation:
    # you can specify the url as a string
    # or you can pass a hash of other items
    # to create a dropdown
    set :nav_left, {
        'Model Example' => '/examples',
        'Payment Example' => '/payment',
        'Reference' => {
            'View on GitHub' => 'https://github.com/qrohlf/hackathon-starter-sinatra',
            'Icons List' => '/css/vendor/icomoon/font_demo.html',
            'Glyph List' => 'http://getbootstrap.com/components/#glyphicons',
            'Bootstrap' => 'http://getbootstrap.com/css/',
            'More Tools' => 'https://github.com/qrohlf/Tools#readme',
            'More Themes' => 'http://bootswatch.com'
        }
    }
end
