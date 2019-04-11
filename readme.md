<h1>TutorHub</h1>
      <p>
        TutorHub is a website dedicated to helping USF students help each other and learn new skills.
        On this website you can learn or teach anything ranging from underwater basket weaving to programming robots.
      </p>
      <p>
        Students are able to...
      </p>
      <ul>
        <li>Share your passions with other students</li>
        <li>Take a wide variety of lessons to expand your knowledge</li>
        <li>Connect with other students sharing the desire to learn new things</li>
      </ul>
      
 <h2>How to Run TutorHub</h2>
 <p>
    TutorHub is run using Ruby 2.4.5 with the following gems:
 </p>
 <ul>
    <li>sinatra</li>
    <li>sinatra-contrib</li>
    <li>dm-sqlite-adapter</li>
    <li>data_mapper</li>
    <li>bcrypt</li>
    <li>sqlite</li>
 </ul>
 <p>After that, run main.rb and the program will start on http://localhost:4567/ </p>
 
 <h2>Troubleshooting</h2>
 <p>If you get error messages about dm-serializer, you might have to modify the json gem installed when you install datamapper.
    If this happens, delete the default gemspec file in C:\Ruby24-x64\lib\ruby\gems\2.4.0\specifications\default for the json
    2.0.4 and run gem install data_mapper again.  
 </p>