Lipstick selector - 

-fix users/show path
-fix lipsticks/show_lipstick path

-organize views



-/lipsticks -> show an index of all of my lipsticks
-/lipsticks/:id -> show a particular lipstick post by :id
-/lipsticks/new -> a form for new lipsticks
-/lipsticks/:id:edit - edit a lipstick

-what do I want?

  -home page (sign up or log in)
  
    -if sign up, registers account then to account page(lipsticks)
    
    -if login, to account page
    
  -lipsticks(account page)
  
    -show all lipsticks from every account in a list.
    
      -include user name in list.
      
    -give link to show all current_user lipsticks.
    
  -show(current_user lipsticks)
  
    -show all current_user lipsticks
    
    -a link to /lipsticks
    
    -auto-generate a link to click for a particular lipstick
    
      -or create a form that brings you to the lipstick of choice
      
  -show_lipstick
  
    -shows 1 lipstick based on id or user
    
      -if user==current_user allow edit link otherwise no
      
    -link to /lipsticks and /user/show
    
    
    