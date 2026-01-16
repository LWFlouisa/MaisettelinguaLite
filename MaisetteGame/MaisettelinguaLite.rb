module BequestCalender
  class LunarSeason
    ######################################################################################
    #                                    Lunar Calender                                  #
    ######################################################################################
    # This establishes the basic mechanics of the Lunar Calender system that modifies    #
    # the player's base metrics on what the current lunar phase, with it being more      #
    # advised to switch to stealth mechanics during the time they are weakest, then      #
    # using the Gribatomaton for when the lunar phase when Bear Men and Kumabatto poses  #
    # the least challenge to them.                                                       #
    #                                                                                    #
    # It remains to be seen whether this will continue to be relevant as I refine this   #
    # this stealth RPG framework.                                                        #
    ######################################################################################

    def self.global_stats
      # Standard Operations
      $stalemates    = 0 # Keeps track of how many stalemates
      $player_struck = 0 # Keeps track of how many times player hit the enemy.
      $enemy_struck  = 0 # Keeps track of how many times enemy hit the player.

      # Amount of days in a year.
      $current_day = 0
      $lunar_ticks = 30

      ## Current Lunar Phase
      $current_phase = 0

      $player_level = 5
      $enemy_level  = 1

      # Yes or no spider
      $has_pet_spider = false

      #$cleaned           = 0 # Amount your clean up crew cleaned.
      #$contamination     = 0 # Contamination spread.
      #$day_counter       = 0 # Thirty days before the next lunar shift.
      #$zombies           = 0 # How many zombies you bludgeons or strangled.

      $baseline_hp   = 10 * $player_level
      $baseline_atk  =  4 * $player_level
      $baseline_def  =  2 * $player_level
      $baseline_heal =  2 * $player_level
      $baseline_san  = 10 * $player_level
      $baseline_tru  = 10 * $player_level

      $baseline_ehp   = 10 * $enemy_level
      $baseline_eatk  =  4 * $enemy_level
      $baseline_edef  =  2 * $enemy_level
      $baseline_eheal =  2 * $enemy_level

      $player_pos = [ 2, 2 ]
      $player_pos = [ $player_pos[0] + 1, $player_pos[1] + 1 ]
      
      $shoe_durability = 10
      $antidotes       = 10
      $emergency_ax    = 10

      # Is the player poisoned?
      $player_poison = false
    
      # It is presently unknown whether water is acidic.
      $water_acidic  = false
  
      # Does the player have a boat that can resist acid lakes?
      $player_boat   = false
  
      # Available monsters for grinding
      $acid_dragon     = 10 # 10 Acid Dragons
      $sea_gargoyal    = 15 # 15 Sea Gargoyals
      $acid_serpent    = 21 # 21 Acid Serpents
      $traitorous_nuns = 15 # 15 Nuns
    end

    def self.new_moon
      $player_hp     = $baseline_atk  * 0.2
      $player_atk    = $baseline_atk  * 0.2
      $player_def    = $baseline_def  * 0.2
      $player_heal   = $baseline_heal * 0.2
      $player_san    = $baseline_san  * 0.2
      $player_tru    = $baseline_tru  * 0.2

      $enemy_hp   = $baseline_ehp   * 0.8
      $enemy_atk  = $baseline_eatk  * 0.8
      $enemy_def  = $baseline_edef  * 0.8
      $enemy_heal = $baseline_eheal * 0.8

      $lunar_phase = "Le phase lunaire es Nouvelle Luna."
      $enemy_name  = "#{$lunar_phase} #{$fauna_type}"
    end

    def self.waxing_crescent
      $player_hp     = $baseline_atk  * 0.4
      $player_atk    = $baseline_atk  * 0.4
      $player_def    = $baseline_def  * 0.4
      $player_heal   = $baseline_heal * 0.4
      $player_san    = $baseline_san  * 0.4
      $player_tru    = $baseline_tru  * 0.4

      $enemy_hp   = $baseline_ehp   * 0.6
      $enemy_atk  = $baseline_eatk  * 0.6
      $enemy_def  = $baseline_edef  * 0.6
      $enemy_heal = $baseline_eheal * 0.6

      $lunar_phase = "Le phase lunaire es Croissant A La Cire."
      $enemy_name  = "#{$lunar_phase} #{$fauna_type}"
    end

    def self.first_quarter
      $player_hp     = $baseline_atk  * 0.6
      $player_atk    = $baseline_atk  * 0.6
      $player_def    = $baseline_def  * 0.6
      $player_heal   = $baseline_heal * 0.6
      $player_san    = $baseline_san  * 0.6
      $player_tru    = $baseline_tru  * 0.6

      $enemy_hp   = $baseline_ehp   * 0.4
      $enemy_atk  = $baseline_eatk  * 0.4
      $enemy_def  = $baseline_edef  * 0.4
      $enemy_heal = $baseline_eheal * 0.4

      $lunar_phase = "Le phase lunaire es Premier Trimestre."
      $enemy_name  = "#{$lunar_phase} #{$fauna_type}"
    end

    def self.waxing_gibbous
      $player_hp     = $baseline_atk  * 0.8
      $player_atk    = $baseline_atk  * 0.8
      $player_def    = $baseline_def  * 0.8
      $player_heal   = $baseline_heal * 0.8
      $player_san    = $baseline_san  * 0.8
      $player_tru    = $baseline_tru  * 0.8

      $enemy_hp   = $baseline_ehp   * 0.4
      $enemy_atk  = $baseline_eatk  * 0.4
      $enemy_def  = $baseline_edef  * 0.4
      $enemy_heal = $baseline_eheal * 0.4

      $lunar_phase = "Le phase lunaire es Cire De Gibbous."
      $enemy_name  = "#{$lunar_phase} #{$fauna_type}"
    end

    def self.full_moon
      $player_hp     = $baseline_atk  #* 0.2
      $player_atk    = $baseline_atk  #* 0.2
      $player_def    = $baseline_def  #* 0.2
      $player_heal   = $baseline_heal #* 0.2
      $player_san    = $baseline_san  #* 0.2
      $player_tru    = $baseline_tru  #* 0.2
		
      $enemy_hp   = $baseline_ehp   * 0.2
      $enemy_atk  = $baseline_eatk  * 0.2
      $enemy_def  = $baseline_edef  * 0.2
      $enemy_heal = $baseline_eheal * 0.2

      $lunar_phase = "Le phase lunaire es Pleine Lune."
      $enemy_name  = "#{$lunar_phase} #{$fauna_type}"
    end

    def self.waning_gibbous
      $player_hp     = $baseline_atk  * 0.6
      $player_atk    = $baseline_atk  * 0.6
      $player_def    = $baseline_def  * 0.6
      $player_heal   = $baseline_heal * 0.6
      $player_san    = $baseline_san  * 0.6
      $player_tru    = $baseline_tru  * 0.6

      $enemy_hp   = $baseline_ehp   * 0.2
      $enemy_atk  = $baseline_eatk  * 0.2
      $enemy_def  = $baseline_edef  * 0.2
      $enemy_heal = $baseline_eheal * 0.2

      $lunar_phase = "Le phase lunaire es Evetement Gibbous."
      $enemy_name  = "#{$lunar_phase} #{$fauna_type}"
    end

    def self.last_quarter
      $player_hp     = $baseline_atk  * 0.4
      $player_atk    = $baseline_atk  * 0.4
      $player_def    = $baseline_def  * 0.4
      $player_heal   = $baseline_heal * 0.4
      $player_san    = $baseline_san  * 0.4
      $player_tru    = $baseline_tru  * 0.4

      $enemy_hp   = $baseline_ehp   * 0.4
      $enemy_atk  = $baseline_eatk  * 0.4
      $enemy_def  = $baseline_edef  * 0.4
      $enemy_heal = $baseline_eheal * 0.4

      $lunar_phase = "Le phase lunaire es Dernier trimestre."
      $enemy_name  = "#{$lunar_phase} #{$fauna_type}"
    end

    def self.waning_crescent
      $player_hp     = $baseline_atk  * 0.2
      $player_atk    = $baseline_atk  * 0.2
      $player_def    = $baseline_def  * 0.2
      $player_heal   = $baseline_heal * 0.2
      $player_san    = $baseline_san  * 0.2
      $player_tru    = $baseline_tru  * 0.2

      $enemy_hp   = $baseline_ehp   * 0.6
      $enemy_atk  = $baseline_eatk  * 0.6
      $enemy_def  = $baseline_edef  * 0.6
      $enemy_heal = $baseline_eheal * 0.6

      $lunar_phase = "Le phase lunaire es Aurfeur."
      $enemy_name  = "#{$lunar_phase} #{$fauna_type}"
    end
    
    def self.evaluate_metrics
      player_hp   = $player_hp
      player_atk  = $player_atk
      player_def  = $player_def
      player_heal = $player_heal
      player_san  = $player_san
      player_tru  = $player_tru
      
      adaptive_hp_minimum = $player_hp * 0.1250
      adaptive_hp_maximum = $player_hp - 2
      
      adaptive_atk_minimum  = $player_atk * 0.1250
      adaptive_atk_maxmimum = $player_atk - 2

      adaptive_def_minimum  = $player_def * 0.1250
      adaptive_def_maxmimum = $player_def - 2

      adaptive_heal_minimum  = $player_atk * 0.1250
      adaptive_heal_maxmimum = $player_atk - 2

      adaptive_san_minimum  = $player_san * 0.1250
      adaptive_san_maxmimum = $player_san - 2

      adaptive_tru_minimum  = $player_atk * 0.1250
      adaptive_tru_maxmimum = $player_atk - 2

      ## Notify about HP status
      current_hp = cette_int($player_hp < adaptive_hp_minimum) do
        puts "Your hit counter is below a critical threshold."
      end

      current_hp = maisette_int(current_hp, $player_hp > adaptive_hp_maximum) do
        puts "Your hit counter is presently thriving."
      end

      current_hp = sinon_int(current_hp) do
        puts "Look for potions in order to maintain your hit counter."
      end

      ## Notify about ATK status
      current_atk = cette_int($player_atk < adpative_atk_minimum) do
        puts "Your attack counter is below a critical threshold."
      end

      current_atk = maisette_int(current_atk, $player_atk > adaptive_atk_maximum) do
        puts "Your attack counter is presently thriving."
      end

      current_atk = sinon_int(current_hp) do
        puts "Look for better weapons to improve your attack counter."
      end

      ## Notify about DEF status
      current_def = cette_int($player_def < adaptive_def_minimum) do
        puts "Your defence counter is below a critical threshold."
      end

      current_def = maisette_int(current_atk, $player_def > adaptive_def_maximum) do
        puts "Your defence counter is presently thriving."
      end

      current_def = sinon_int(current_hp) do
        puts "Look for better shielding in order to maintain your defence counter."
      end
    end

    def self.lunar_cycle
      lunar_phases = [0, 1, 2, 3, 4, 5, 6, 7]

      # The current lunar phase mod 7
      current_phase  = $current_phase % 7
      #$current_phase = $current_phase + 1 % 7

      if    current_phase == lunar_phases[0]
        puts "\e[38;2;187;127;118mLa phase lunaire actuelle est: New Moon. Réinitialisation des statistiques du joueur...\e[0m"

        sleep(1)

        BequestCalender::LunarSeason.new_moon
        BequestCalender::LunarSeason.evaluate_metrics
      elsif current_phase == lunar_phases[1]
        puts "\e[38;2;187;127;118mLa phase lunaire actuelle est: Waxing Gibbous. Réinitialisation des statistiques du joueur...\e[0m"

        sleep(1)

        BequestCalender::LunarSeason.waxing_crescent
      elsif current_phase == lunar_phases[2]
        puts "\e[38;2;187;127;118mLa phase lunaire actuelle est: Waxing Gibbous. Réinitialisation des statistiques du joueur...\e[0m"

        sleep(1)

        BequestCalender::LunarSeason.first_quarter
      elsif current_phase == lunar_phases[3]
        puts "\e[38;2;187;127;118mLa phase lunaire actuelle est: First Quarter. Réinitialisation des statistiques du joueur...\e[0m"

        sleep(1)

        BequestCalender::LunarSeason.waxing_gibbous
      elsif current_phase == lunar_phases[4]
        puts "\e[38;2;187;127;118mLa phase lunaire actuelle est: Full_moon. Réinitialisation des statistiques du joueur...\e[0m"

        sleep(1)

        BequestCalender::LunarSeason.full_moon
      elsif current_phase == lunar_phases[5]
        puts "\e[38;2;187;127;118mLa phase lunaire actuelle est: Waning Gibbous. Réinitialisation des statistiques du joueur...\e[0m"

        sleep(1)

        BequestCalender::LunarSeason.waning_gibbous
      elsif current_phase == lunar_phases[6]
        puts "\e[38;2;187;127;118mLa phase lunaire actuelle est: Last Quarter. Réinitialisation des statistiques du joueur...\e[0m"

        sleep(1)

        BequestCalender::LunarSeason.last_quarter
      elsif current_phase == lunar_phases[7]
        puts "\e[38;2;187;127;118mLa phase lunaire actuelle est: Waning Crescent. Réinitialisation des statistiques du joueur...\e[0m"

        sleep(1)

        BequestCalender::LunarSeason.waning_crescent
      end

      sleep(1.5)
    end
  end
end

###################################################################################
#                                   Coral Pool                                    #
###################################################################################
# This is for polyp and coral based mechanics where story elements are gradually  #
# revealed through the introductions of subroutines in environments based on      #
# coral ecosystems.                                                               #
###################################################################################
module CoralPool
  class IsolatedCoral
    def self.knowledge_gaps
      a = [ "my house",         "fruit",             "escelator entrance", "second floor item drop" ]
      b = [ "friends house",    "vegetables",        "escelator entrance", "second floor item drop" ]
      c = [ "sisters house",    "shoes",             "escelator entrance", "second floor item drop" ]
      d = [ "bullys house",     "meat",              "escelator entrance", "second floor item drop" ]
      e = [ "teachers house",   "books",             "escelator entrance", "second floor item drop" ]
      f = [ "firemans house",   "hoses",             "escelator entrance", "second floor item drop" ]
      g = [ "simpsons house",   "jokebooks",         "escelator entrance", "second floor item drop" ]
      h = [ "dragons house",    "iron statues",      "escelator entrance", "second floor item drop" ]
      i = [ "hamburgers house", "condiment shelves", "escelator entrance", "second floor item drop" ]

      #puts is_house_deceptive?(a[0][0], deux_chemix_ascenseur(a[1], a[2], a[3]))
      
      analyze_sabofensu(is_house_deceptive?(a[0], deux_chemix_ascenseur(a[1], a[2], a[3])),
                        is_house_deceptive?(b[0], deux_chemix_ascenseur(b[1], b[2], b[3])),
                        is_house_deceptive?(c[0], deux_chemix_ascenseur(c[1], c[2], c[3])))
                        
      analyze_sabofensu(is_house_deceptive?(d[0], deux_chemix_ascenseur(d[1], d[2], d[3])),
                        is_house_deceptive?(e[0], deux_chemix_ascenseur(e[1], e[2], e[3])),
                        is_house_deceptive?(f[0], deux_chemix_ascenseur(f[1], f[2], f[3])))
                        
      analyze_sabofensu(is_house_deceptive?(g[0], deux_chemix_ascenseur(g[1], g[2], g[3])),
                        is_house_deceptive?(h[0], deux_chemix_ascenseur(h[1], h[2], h[3])),
                        is_house_deceptive?(i[0], deux_chemix_ascenseur(i[1], i[2], i[3])))
    end
    
    # Confirmed dreams
    def self.dream_studies
      a = [ "my house",                  "This is my house." ]
      b = [ "friends house",    "This is my friend's house." ]
      c = [ "sisters house",     "This is my sisters house." ]
      d = [ "bullys house",       "This is my bullys house." ]
      e = [ "teachers house",  "This is my teacher's house." ]
      f = [ "firemans house",   "This is a fireman's house." ]    

      etudie_de_yume(a[0], a[1],
                     b[0], b[1],
                     c[0], c[1])

      etudie_de_yume(d[0], d[1],
                     e[0], e[1],
                     f[0], f[1])
    end
    
    # Isolated "dream" studies
    def self.unknown_dreams
      etudie_de_yume("my_house",                     "This is my house.",
                     "friends_house",        "This is my friends house.",
                     "sisters_house",        "This is my sisters house.")
                     
      etudie_de_yume("my_school",                    "This is my school.",
                     "friends_school",       "This is my friends school.",
                     "sisters_school",       "This is my sisters school.")
      
      etudie_de_yume("my_church",                    "This is my church.",
                     "friends_church",       "This is my friends church.",
                     "sisters_church",       "This is my sisters church.")
      
      etudie_de_yume("my_grocery",                   "This is my grocery.",
                     "friends_grocery",      "This is my friends grocery.",
                     "sisters_grocery",      "This is my sisters grocery.")
      
      etudie_de_yume("my_garage",                    " This is my garage.",
                     "friends_garage",        "This is my friends garage.",
                     "sisters_garage",        "This is my sisters garage.")
      
      etudie_de_yume("my_neighborhood",              "This is my neighborhood.",
                     "friends_neighborhood", "This is my friends neighborhood.",
                     "sisters_neighborhood", "This is my sisters neighborhood.")
      
      etudie_de_yume("my_neighborhood",              "This is my neighborhood.",
                     "friends_neighborhood", "This is my friends neighborhood.",
                     "sisters_neighborhood", "This is my sisters neighborhood.")
      
      etudie_de_yume("my_neighborhood",              "This is my neighborhood.",
                     "friends_neighborhood", "This is my friends neighborhood.",
                     "sisters_neighborhood", "This is my sisters neighborhood.")
    end
    
    def self.show_deception
      a = [ "my house",         "fruit",             "escelator entrance", "second floor item drop" ]
      b = [ "friends house",    "vegetables",        "escelator entrance", "second floor item drop" ]
      c = [ "sisters house",    "shoes",             "escelator entrance", "second floor item drop" ]
      
      show_deception(is_house_deceptive?(a[0], deux_chemix_ascenseur(a[1], a[2], a[3])),
                    is_house_deceptive?(b[0], deux_chemix_ascenseur(a[1], b[2], b[3])),
                    is_house_deceptive?(c[0], deux_chemix_ascenseur(a[1], c[2], c[3])))
    end

    def self.suspicious_logic
      puts is_house_deceptive?("my house",      deux_chemix_ascenseur(cette("pomme", "rouge"),         "the escelator entrance", "the item drop"))
      puts is_house_deceptive?("friends house", deux_chemix_ascenseur(maisette("pomme", "vert"),       "the escelator entrance", "the item drop"))
      puts is_house_deceptive?("sisters house", deux_chemix_ascenseur(sinon("pomme", "rouge", "vert"), "the escelator entrance", "the item drop"))
    end
    
    def self.ternary_polypation
      ai_information_status = $ai_information_status
    
      ## Standard
      current_information_state = sorewa_float(ai_information_status < 0.1250 ) do
        2.times do
          get_statistics(:distribute_polyps,       "A singular polyp has colonized a rock in an underground swimming pool.";
                         :birth_of_medusa,   "The polyp grows into a bell, propelling itself through the underground lake.",
                         :bud_spreading,                             "The medusa spreads its buds before its final demise.")
                         
                         dynamic_reward_allocation
        end
        
        thresholding($current_probability, 12, 12)
      end

      current_information_state = shikashiwa_float(current_information_state, ai_information_status > 0.9 ) do
        2.times do
          get_statistics(:distribute_polyps,       "A singular polyp has colonized a rock in an underground swimming pool.";
                         :birth_of_medusa,   "The polyp grows into a bell, propelling itself through the underground lake.",
                         :bud_spreading,                             "The medusa spreads its buds before its final demise.")
                         
                         dynamic_reward_allocation
        end
        
        thresholding($current_probability, 12, 12)      
      end

      current_information_state = matawa_float(current_information_state, ai_information_status > 0.9 ) do
        2.times do
          get_statistics(:distribute_polyps,       "A singular polyp has colonized a rock in an underground swimming pool.";
                         :birth_of_medusa,   "The polyp grows into a bell, propelling itself through the underground lake.",
                         :bud_spreading,                             "The medusa spreads its buds before its final demise.")
                         
                         dynamic_reward_allocation
        end
        
        thresholding($current_probability, 12, 12)
      end
      
      ## Hanten-Ronri
      current_information_state = nisorewa_float(ai_information_status < 0.1250 ) do
        2.times do
          get_statistics(:distribute_polyps,       "A singular polyp has colonized a rock in an underground swimming pool.";
                         :birth_of_medusa,   "The polyp grows into a bell, propelling itself through the underground lake.",
                         :bud_spreading,                             "The medusa spreads its buds before its final demise.")
                         
                         dynamic_reward_allocation
        end
        
        thresholding($current_probability, 12, 12)
      end

      current_information_state = nishikashiwa_float(current_information_state, ai_information_status > 0.9 ) do
        2.times do
          get_statistics(:distribute_polyps,       "A singular polyp has colonized a rock in an underground swimming pool.";
                         :birth_of_medusa,   "The polyp grows into a bell, propelling itself through the underground lake.",
                         :bud_spreading,                             "The medusa spreads its buds before its final demise.")
                         
                         dynamic_reward_allocation
        end
        
        thresholding($current_probability, 12, 12)
      end

      current_information_state = nimatawa_float(current_information_state, ai_information_status > 0.9 ) do
        2.times do
          get_statistics(:distribute_polyps,       "A singular polyp has colonized a rock in an underground swimming pool.";
                         :birth_of_medusa,   "The polyp grows into a bell, propelling itself through the underground lake.",
                         :bud_spreading,                             "The medusa spreads its buds before its final demise.")
                         
                         dynamic_reward_allocation
        end
        
        thresholding($current_probability, 12, 12)
      end
    end
  end
  
  class OvertPolyps
    def self.knowledge_gap
      puts "\nKNOWLEFGE GAPS"
      CoralPool::IsolatedCoral.knowledge_gaps
    end

    def self.dream_studies
      puts "\nDREAM STUDIES"
      CoralPool::IsolatedCoral.dream_studies
    end
    
    def self.unknown_dreams
      puts "\nUNKNOWN DREAMS"
      CoralPool::IsolatedCoral.unknown_dreams
    end
    
    def self.show_deception
      puts "\nSHOW DECEPTION"
      CoralPool::IsolatedCoral.show_deception
    end

    def self.suspicious_logic
      puts "\nSUSPICIOUS LOGIC"
      CoralPool::IsolatedCoral.suspicious_logic
    end
  
    def self.polyp_reefs
      puts "\nPOLYPING REEFS"
      CoralPool::IsolatedCoral.ternary_polypation
    end
    
    def self.vent_de_corail
      print "What aspect of coral to analyze? << "; analyze = gets.chomp
      
      if    analyze ==   "knowledge gaps"; CoralPool::OvertPolyps.knowledge_gap
      elsif analyze ==    "dream studies"; CoralPool::OvertPolyps.dream_studies
      elsif analyze ==  "show deceptions"; CoralPool::OvertPolyps.unknown_dreams
      elsif analyze == "suspicious logic"; CoralPool::OvertPolyps.show_deception
      elsif analyze ==      "polyp reefs"; CoralPool::OvertPolyps.suspicious_logic
    end
  end
end

################################################################################################
#                                            Map                                               #
################################################################################################
module MapMechanics
  class MapImages    
    def self.draw_map(map, p_x, p_y, p_char)
      map.each_with_index do |row, y|
        row.each_with_index do |tile, x|

        if x == p_x and y == p_y
          print p_char # Draw the player
        else
          print tile   # Draw the floor/wall
        end
      end
      
      puts "" # Move to the next line
    end

    def self.display_map
      map = [
        ["#", "#", "#", ".", "#", "#", "#"],
        ["#", ".", ".", ".", ".", ".", "#"],
        ["#", ".", ".", ".", ".", ".", "#"],
        [".", ".", ".", ".", ".", ".", "."],
        ["#", ".", ".", ".", ".", ".", "#"],
        ["#", ".", ".", ".", ".", ".", "#"],
        ["#", "#", "#", ".", "#", "#", "#"],
      ]

      player_x = $player_pos[0]
      player_y = $player_pos[1]
      player_char = "@"
      
      draw_map(map, player_x, player_y, player_char)
    end
  end
  
  class MapDescriptions
    def self.describe_paris
      MapMechanics::MapImages.display_map

      puts "This is an infinite version of Paris."
    end

    def self.describe_ruins
      MapMechanics::MapImages.display_map

      puts "This is an infinite version of Ruins."
    end

    def self.describe_subway
      MapMechanics::MapImages.display_map

      puts "This is an infinite version of Subway."
    end
  end
  
  class MapNavigation
    def self.move(direction)
      new_pos          = $player_pos
  
      case direction
        when :north then new_pos[1] += 1
        when :south then new_pos[1] -= 1
        when :east  then new_pos[0] += 1
        when :west  then new_pos[0] -= 1
      end
    end
    
    def self.describe_places
      current_location = $location.to_s
      
      if    current_location == "liminal_ruins"
        MapMechanics::MapDescriptions.describe_ruins
      elsif current_location == "liminal_subway"
        MapMechanics::MapDescriptions.describe_subway
      elsif current_location == "liminal_paris"
        MapMechanics::MapDescriptions.describe_paris
      else
        puts "This location is presently uncharted."
      end
    end
    
    def self.room_selection
      a = "liminal_ruins"
      b = "liminal_paris"
      c = "liminal_subway"
    
      possible_rooms = [
        [[a, a, a], [a, a, b], [a, a, c]],
        [[b, b, a], [b, b, b], [b, b, c]],
        [[c, c, a], [c, c, b], [c, c, c]],
      ]
      
      row_options = [0, 1, 2]
      col_options = [0, 1, 2]
      arr_options = [0, 1, 2]
      
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
      
      current_room = possible_rooms[cur_row][cur_col][cur_arr]
      
      current_room
    end
  end
end

################################################################################################
#                                     Card Game Mechanics                                      #
################################################################################################
module CardShuffler
  class PredictCards
    def self.scroll_of_air
      air_card_types = [
         "Esu",  "Roi",  "Reine",  "Jakku",
         "Dix", "Neuf",   "Huit", "Seibun", # Seibun is a pun on "reaching" and the number seven.
         "Six", "cinq", "quatre",  "trois"
        "deux"
      ]
      
      air_card_initializer = File.read("data/cards/air/selection/choice.txt").strip.to_i
      
      $air_card_value = air_card_initializer
      
      current_selection = air_card_types[air_card_initializer]
      
      "Your current card is #{current_selection} "
    end

    def self.scroll_of_electricity
      electricity_card_types = [
         "Esu",  "Roi",  "Reine",  "Jakku",
         "Dix", "Neuf",   "Huit", "Seibun", # Seibun is a pun on "reaching" and the number seven.
         "Six", "cinq", "quatre",  "trois"
        "deux"
      ]
      
      electricity_card_initializer = File.read("data/cards/electricity/selection/choice.txt").strip.to_i
      
      $electricity_card_value = electricity_card_initializer
      
      current_selection = electricity_card_types[electricity_card_initializer]
      
      "Your current card is #{current_selection} "
    end

    def self.scroll_of_healing
      healing_card_types = [
         "Esu",  "Roi",  "Reine",  "Jakku",
         "Dix", "Neuf",   "Huit", "Seibun", # Seibun is a pun on "reaching" and the number seven.
         "Six", "cinq", "quatre",  "trois"
        "deux"
      ]
      
      healing_card_initializer = File.read("data/cards/heaven/selection/choice.txt").strip.to_i
      
      $healing_card_value = healing_card_initializer
      
      current_selection = healing_card_initializer[healing_card_initializer]
      
      "Your current card is #{current_selection} "
    end

    def self.scroll_of_poison
      poison_card_types = [
         "Esu",  "Roi",  "Reine",  "Jakku",
         "Dix", "Neuf",   "Huit", "Seibun", # Seibun is a pun on "reaching" and the number seven.
         "Six", "cinq", "quatre",  "trois"
        "deux"
      ]
      
      poison_card_initializer = File.read("data/cards/poison/selection/choice.txt").strip.to_i
      
      $poison_card_value = heaven_card_initializer
      
      current_selection = poison_card_types[poison_card_initializer]
      
      "Your current card is #{current_selection} "
    end

    def self.scroll_of_stone
      stone_card_types = [
         "Esu",  "Roi",  "Reine",  "Jakku",
         "Dix", "Neuf",   "Huit", "Seibun", # Seibun is a pun on "reaching" and the number seven.
         "Six", "cinq", "quatre",  "trois"
        "deux"
      ]
      
      stone_card_initializer = File.read("data/cards/stone/selection/choice.txt").strip.to_i
      
      $stone_card_value = stone_card_initializer
      
      current_selection = stone_card_types[stone_card_initializer]
      
      "Your current card is #{current_selection} "
    end

    def self.scroll_of_death
      death_card_types = [
         "Esu",  "Roi",  "Reine",  "Jakku",
         "Dix", "Neuf",   "Huit", "Seibun", # Seibun is a pun on "reaching" and the number seven.
         "Six", "cinq", "quatre",  "trois"
        "deux"
      ]
      
      death_card_initializer = File.read("data/cards/death/selection/choice.txt").strip.to_i
      
      $death_card_value = death_card_initializer
      
      current_selection = death_card_types[death_card_initializer]
      
      "Your current card is #{current_selection} "
    end

    def self.scroll_of_divinity
      divinity_card_types = [
         "Esu",  "Roi",  "Reine",  "Jakku",
         "Dix", "Neuf",   "Huit", "Seibun", # Seibun is a pun on "reaching" and the number seven.
         "Six", "cinq", "quatre",  "trois"
        "deux"
      ]
      
      divinity_card_initializer = File.read("data/cards/divinity/selection/choice.txt").strip.to_i
      
      $divinity_card_value = divinity_card_initializer
      
      current_selection = divinity_card_types[divinity_card_initializer]
      
      "Your current card is #{current_selection} "
    end

    def self.scroll_of_binding
      binding_card_types = [
         "Esu",  "Roi",  "Reine",  "Jakku",
         "Dix", "Neuf",   "Huit", "Seibun", # Seibun is a pun on "reaching" and the number seven.
         "Six", "cinq", "quatre",  "trois"
        "deux"
      ]
      
      binding_card_initializer = File.read("data/cards/binding/selection/choice.txt").strip.to_i
      
      $binding_card_value = binding_card_initializer
      
      current_selection = binding_card_types[binding_card_initializer]
      
      "Your current card is #{current_selection} "
    end
  end
  
  class ReasonAboutCards
    def self.cette_int(condition)
      if condition
        yield
    
        return true
      end
  
      false
    end

    def self.maisette_int(already_done, condition)
      return true if already_done
  
      if condition
        yield
    
        return true
      end
    end

    def self.sinon_int(already_done)
      yield unless already_done
  
      unless already_done
        puts "Card actions have not yet been defined..."
      
        #if defined?($otherwise)
        #  puts "#{$otherwise[0]} is 'THAT'"
        #  puts "#{$otherwise[1]} is 'WHAT'"
        #end
      end
    end
  
    def self.scroll_of_air
      current_card = CardShuffler::PredictCards.scroll_of_air
      
      print current_card
      
      # For card of air, that character defaults to if HP, ATK, DEF, HEALING, SANITY, or TRUST is above critical_limit or below thriving_threshold.
      air_scroll = CardShuffler::ReasonAboutCards.cette_int($air_card_value < 4) do
        puts "You card is not high enough."

        # That plot threads happen here
      end
      
      air_scroll = CardShuffler::ReasonAboutCards.maisette_int(air_scroll, $air_card_value > 11) do
        puts "Your current card is high enough."

        # But that plot threads happen here
      end
      
      air_scroll = CardShuffler::ReasonAboutCards.sinon_int(air_scroll) do
        puts "Be mindful of having cards values that might standards."

        # Otherwise plot threads happen here
      end
    end

    def self.scroll_of_electricity
      current_card = CardShuffler::PredictCards.scroll_of_electricity
      
      # For card of air, that character defaults to if HP, ATK, DEF, HEALING, SANITY, or TRUST is above critical_limit or below thriving_threshold.
      electric_scroll = CardShuffler::ReasonAboutCards.cette_int($electricity_card_value < 4) do
        puts "You card is not high enough."
      end
      
      electric_scroll = CardShuffler::ReasonAboutCards.maisette_int(electric_scroll, $electricity_card_value > 11) do
        puts "Your current card is high enough."
      end
      
      electric_scroll = CardShuffler::ReasonAboutCards.sinon_int(electric_scroll) do
        puts "Be mindful of having cards values that might standards."
      end
    end

    def self.scroll_of_healing
      current_card = CardShuffler::PredictCards.scroll_of_heaven
      
      # For card of air, that character defaults to if HP, ATK, DEF, HEALING, SANITY, or TRUST is above critical_limit or below thriving_threshold.
      healing_scroll = CardShuffler::ReasonAboutCards.cette_int($healing_card_value < 4) do
        puts "You card is not high enough."
      end
      
      healing_scroll = CardShuffler::ReasonAboutCards.maisette_int(healing_scroll, $healing_card_value > 11) do
        puts "Your current card is high enough."
      end
      
      healing_scroll = CardShuffler::ReasonAboutCards.sinon_int(healing_scroll) do
        puts "Be mindful of having cards values that might standards."
      end
    end

    def self.scroll_of_poison
      current_card = CardShuffler::PredictCards.scroll_of_poison
      
      # For card of air, that character defaults to if HP, ATK, DEF, HEALING, SANITY, or TRUST is above critical_limit or below thriving_threshold.
      poison_scroll = CardShuffler::ReasonAboutCards.cette_int($poison_card_value < 4) do
        puts "You card is not high enough."
      end
      
      poison_scroll = CardShuffler::ReasonAboutCards.maisette_int(poison_scroll, $poison_card_value > 11) do
        puts "Your current card is high enough."
      end
      
      poison_scroll = CardShuffler::ReasonAboutCards.sinon_int(poison_scroll) do
        puts "Be mindful of having cards values that might standards."
      end
    end

    def self.scroll_of_stone
      current_card = CardShuffler::PredictCards.scroll_of_stone
      
      # For card of air, that character defaults to if HP, ATK, DEF, HEALING, SANITY, or TRUST is above critical_limit or below thriving_threshold.
      stone_scroll = CardShuffler::ReasonAboutCards.cette_int($stone_card_value < 4) do
        puts "You card is not high enough."
      end
      
      stone_scroll = CardShuffler::ReasonAboutCards.maisette_int(stone_scroll, $stone_card_value > 11) do
        puts "Your current card is high enough."
      end
      
      stone_scroll = CardShuffler::ReasonAboutCards.sinon_int(stone_scroll) do
        puts "Be mindful of having cards values that might standards."
      end
    end

    def self.scroll_of_death
      current_card = CardShuffler::PredictCards.scroll_of_death
      
      # For card of air, that character defaults to if HP, ATK, DEF, HEALING, SANITY, or TRUST is above critical_limit or below thriving_threshold.
      death_scroll = CardShuffler::ReasonAboutCards.cette_int($death_card_value < 4) do
        puts "You card is not high enough."
      end
      
      death_scroll = CardShuffler::ReasonAboutCards.maisette_int(stone_scroll, $death_card_value > 11) do
        puts "Your current card is high enough."
      end
      
      death_scroll = CardShuffler::ReasonAboutCards.sinon_int(death_scroll) do
        puts "Be mindful of having cards values that might standards."
      end
    end

    def self.scroll_of_divinity
      current_card = CardShuffler::PredictCards.scroll_of_divinity
      
      # For card of air, that character defaults to if HP, ATK, DEF, HEALING, SANITY, or TRUST is above critical_limit or below thriving_threshold.
      divinity_scroll = CardShuffler::ReasonAboutCards.cette_int($divinity_card_value < 4) do
        puts "You card is not high enough."
      end
      
      divinity_scroll = CardShuffler::ReasonAboutCards.maisette_int(stone_scroll, $divinity_card_value > 11) do
        puts "Your current card is high enough."
      end
      
      divinity_scroll = CardShuffler::ReasonAboutCards.sinon_int(divinity_scroll) do
        puts "Be mindful of having cards values that might standards."
      end
    end

    def self.scroll_of_binding
      current_card = CardShuffler::PredictCards.scroll_of_binding
      
      # For card of air, that character defaults to if HP, ATK, DEF, HEALING, SANITY, or TRUST is above critical_limit or below thriving_threshold.
      binding_scroll = CardShuffler::ReasonAboutCards.cette_int($binding_card_value < 4) do
        puts "You card is not high enough."
      end
      
      binding_scroll = CardShuffler::ReasonAboutCards.maisette_int(stone_scroll, $binding_card_value > 11) do
        puts "Your current card is high enough."
      end
      
      binding_scroll = CardShuffler::ReasonAboutCards.sinon_int(binding_scroll) do
        puts "Be mindful of having cards values that might standards."
      end
    end
  end
  
  class PredictNextCard
    def self.get_statistics(a1, a2, b1, b2, c1, c2, d1, d2)
      a = a1, a2
      b = b1, b2
      c = c1, c2
      d = d1, d2
 
      matrix = [
        [[a[0], a[0], a[0], a[0]],
         [a[0], a[0], a[0], b[0]],
         [a[0], a[0], a[0], c[0]],
         [a[0], a[0], a[0], d[0]]],
 
       [[b[0], b[0], b[0], a[0]],
        [b[0], b[0], b[0], b[0]],
        [b[0], b[0], b[0], c[0]],
        [b[0], b[0], b[0], d[0]]],

       [[c[0], c[0], c[0], a[0]],
        [c[0], c[0], c[0], b[0]],
        [c[0], c[0], c[0], c[0]],
        [c[0], c[0], c[0], d[0]]],
 
       [[d[0], d[0], d[0], a[0]],
        [d[0], d[0], d[0], b[0]],
        [d[0], d[0], d[0], c[0]],
        [d[0], d[0], d[0], d[0]]],
     ], [
       [[a[1], a[1], a[1], a[1]],
        [a[1], a[1], a[1], b[1]],
        [a[1], a[1], a[1], c[1]],
        [a[1], a[1], a[1], d[1]]],
 
       [[b[1], b[1], b[1], a[1]],
        [b[1], b[1], b[1], b[1]],
        [b[1], b[1], b[1], c[1]],
        [b[1], b[1], b[1], d[1]]],
 
       [[c[1], c[1], c[1], a[1]],
        [c[1], c[1], c[1], b[1]],
        [c[1], c[1], c[1], c[1]],
        [c[1], c[1], c[1], d[1]]],
 
       [[d[1], d[1], d[1], a[1]],
        [d[1], d[1], d[1], b[1]],
        [d[1], d[1], d[1], c[1]],
        [d[1], d[1], d[1], d[1]]],
     ], [
       [[0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25]],
 
       [[0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25]],
 
       [[0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25]],
 
       [[0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25]],
     ]

     label_type       = matrix[0]
     definition_type  = matrix[1]
     probability_type = matrix[2]
  
     row_probability = 0.25
     col_probability = 0.25
  
     graph_selection = row_probability * col_probability

     row_options = [0, 1, 2, 3]
     col_options = [0, 1, 2, 3]
     arr_options = [0, 1, 2, 3]

     cur_row = row_options.sample
     cur_col = col_options.sample
     cur_arr = arr_options.sample
  
     current_label       = label_type[cur_row][cur_col][cur_arr]
     current_definition  = definition_type[cur_row][cur_col][cur_arr]
     current_probability = probability_type[cur_row][cur_col][cur_arr] * graph_selection
  
     "I'm confident it is not [ #{current_label} #{current_definition} ] as it has only #{current_probability} probability."
 
     $current_label       = current_label
     $current_probability = current_probability + current_probability
     $current_information = "#{current_label} #{current_definition}"
   end
   
   def self.reasses
     if $current_probability > 0.999999999999999999
       $current_probability = 0.9 / $current_probability
     end
   
     case $current_probability
     when 0.003921569000000000..0.287225000000000000
       "I'm confident it is not [ #{$current_information} ] because it has #{$current_probability}."
     when 0.287225000000000001..0.522225000000000000
       "I'm less unconfident it is not [ #{$current_information} ] because it has #{$current_probability}."
     when 0.522225000000000001..0.756112500000000000
       "I'm almost sure it is [ #{$current_information} ] because it has #{$current_probability}."
     when 0.756112500000000001..0.999999999999999999
       "I'm sure it is [ #{$current_information} ] because it has #{$current_probability}."

     else
       puts "The probability is either to low or to large, so I can't determine exactly."
     end
  
     $current_probability = $current_probability + $current_probability
   end

   def self.reconsider
     if $current_probability > 0.999999999999999999
       $current_probability = 0.9 / $current_probability
     end

     case $current_probability
     when 0.003921569000000000..0.287225000000000000
       "I'm confident it is not [ #{$current_information} ] because it has #{$current_probability}."
     when 0.287225000000000001..0.522225000000000000
       "I'm less unconfident it is not [ #{$current_information} ] because it has #{$current_probability}."
     when 0.522225000000000001..0.756112500000000000
       "I'm almost sure it is [ #{$current_information} ] because it has #{$current_probability}."
     when 0.756112500000000001..0.999999999999999999
       "I'm sure it is [ #{$current_information} ] because it has #{$current_probability}."
     else
       puts "The probability is either to low or to large, so I can't determine exactly."
     end
  
     old_probability      = $current_probability
     $current_probability = $current_probability / old_probability
   end

   def self.dynamic_reward_allocation
     l1_reasses = "level one reasses"
     l2_reasses = "level two reasses"
     l3_reasses = "level tre reasses"
     l4_reasses = "level fro reasses"

     reward_model = [
       [[l1_reasses, l1_reasses, l1_reasses, l1_reasses],
        [l1_reasses, l1_reasses, l1_reasses, l2_reasses],
        [l1_reasses, l1_reasses, l1_reasses, l3_reasses],
        [l1_reasses, l1_reasses, l1_reasses, l4_reasses]],
   
       [[l2_reasses, l2_reasses, l2_reasses, l1_reasses],
        [l2_reasses, l2_reasses, l2_reasses, l2_reasses],
        [l2_reasses, l2_reasses, l2_reasses, l3_reasses],
        [l2_reasses, l2_reasses, l2_reasses, l4_reasses]],
   
       [[l3_reasses, l3_reasses, l3_reasses, l1_reasses],
        [l3_reasses, l3_reasses, l3_reasses, l2_reasses],
        [l3_reasses, l3_reasses, l3_reasses, l3_reasses],
        [l3_reasses, l3_reasses, l3_reasses, l4_reasses]],
   
       [[l4_reasses, l4_reasses, l4_reasses, l1_reasses],
        [l4_reasses, l4_reasses, l4_reasses, l2_reasses],
        [l4_reasses, l4_reasses, l4_reasses, l3_reasses],
        [l4_reasses, l4_reasses, l4_reasses, l4_reasses]],
     ]

     row_options = [0, 1, 2, 3]
     col_options = [0, 1, 2, 3]
     arr_options = [0, 1, 2, 3]

     cur_row = row_options.sample
     cur_col = col_options.sample
     cur_arr = arr_options.sample

     current_reward_structure = reward_model[cur_row][cur_col][cur_arr]
 
     if    current_reward_structure == l1_reasses; CardShuffler::ReasonAboutCards.reasses
     elsif current_reward_structure == l2_reasses; 2.times do CardShuffler::ReasonAboutCards.reasses end
     elsif current_reward_structure == l3_reasses; 3.times do CardShuffler::ReasonAboutCards.reasses end
     elsif current_reward_structure == l4_reasses; 4.times do CardShuffler::ReasonAboutCards.reasses end
     else
       CardShuffler::ReasonAboutCards.reasses
     end
   end

   def self.dynamic_guillotine_allocation
     l1_reasses = "level one reasses"
     l2_reasses = "level two reasses"
     l3_reasses = "level tre reasses"
     l4_reasses = "level fro reasses"

     reward_model = [
       [[l1_reasses, l1_reasses, l1_reasses, l1_reasses],
        [l1_reasses, l1_reasses, l1_reasses, l2_reasses],
        [l1_reasses, l1_reasses, l1_reasses, l3_reasses],
        [l1_reasses, l1_reasses, l1_reasses, l4_reasses]],
   
       [[l2_reasses, l2_reasses, l2_reasses, l1_reasses],
        [l2_reasses, l2_reasses, l2_reasses, l2_reasses],
        [l2_reasses, l2_reasses, l2_reasses, l3_reasses],
        [l2_reasses, l2_reasses, l2_reasses, l4_reasses]],
 
       [[l3_reasses, l3_reasses, l3_reasses, l1_reasses],
        [l3_reasses, l3_reasses, l3_reasses, l2_reasses],
        [l3_reasses, l3_reasses, l3_reasses, l3_reasses],
        [l3_reasses, l3_reasses, l3_reasses, l4_reasses]],
   
       [[l4_reasses, l4_reasses, l4_reasses, l1_reasses],
        [l4_reasses, l4_reasses, l4_reasses, l2_reasses],
        [l4_reasses, l4_reasses, l4_reasses, l3_reasses],
        [l4_reasses, l4_reasses, l4_reasses, l4_reasses]],
     ]

     row_options = [0, 1, 2, 3]
     col_options = [0, 1, 2, 3]
     arr_options = [0, 1, 2, 3]

     cur_row = row_options.sample
     cur_col = col_options.sample
     cur_arr = arr_options.sample

     current_reward_structure = reward_model[cur_row][cur_col][cur_arr]
 
     if    current_reward_structure == l1_reasses; CardShuffler::ReasonAboutCards.reconsider
     elsif current_reward_structure == l2_reasses; 2.times do CardShuffler::ReasonAboutCards.reconsider end
     elsif current_reward_structure == l3_reasses; 3.times do CardShuffler::ReasonAboutCards.reconsider end
     elsif current_reward_structure == l4_reasses; 4.times do CardShuffler::ReasonAboutCards.reconsider end
     else
       CardShuffler::ReasonAboutCards.reconsider
     end
   end

   def self.dynamic_mode_switcher
      modes = [
        [["deposit", "deposit"], ["deposit", "extract"]],
        [["extract", "deposit"], ["extract", "extract"]],
     ]
  
     row_options = [0, 1]
     col_options = [0, 1]
     arr_options = [0, 1]

     cur_row = row_options.sample
     cur_col = col_options.sample
     cur_arr = arr_options.sample 

     current_mode = modes[cur_row][cur_col][cur_arr]

     if    current_mode == "deposit"; CardShuffler::ReasonAboutCards.dynamic_reward_allocation
     elsif current_mode == "extract"; CardShuffler::ReasonAboutCards.dynamic_guillotine_allocation
     else
       CardShuffler::ReasonAboutCards.dynamic_guillotine_allocation
     end
   end
  
    def self.scroll_of_air
      CardShuffler::PredictCards.scroll_of_air
      CardShuffler::ReasonAboutCards.scroll_of_air
      
      2.times do
        CardShuffler::ReasonAboutCards.get_statistics(:esu,     "Esu",
                                                      :roi,     "Roi",
                                                      :reine, "Reine")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:jakku, "Jakku",
                                                      :dix,     "Dix",
                                                      :huit,   "Huit")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:seibun, "Seibun",
                                                      :six,       "Six",
                                                      :cinq,     "Cinq")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:seibun, "Seibun",
                                                      :six,       "Six",
                                                      :cinq,     "Cinq")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:quatre, "Quatre",
                                                      :trois,   "Trois",
                                                      :deux,     "Deux")
                       
        CardShuffler::ReasonAboutCards.dynamic_mode_switcher
      end
    end

    def self.scroll_of_electricity
      CardShuffler::PredictCards.scroll_of_electricity
      CardShuffler::ReasonAboutCards.scroll_of_electricity
      
      2.times do
        CardShuffler::ReasonAboutCards.get_statistics(:esu,     "Esu",
                                                      :roi,     "Roi",
                                                      :reine, "Reine")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:jakku, "Jakku",
                                                      :dix,     "Dix",
                                                      :huit,   "Huit")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:seibun, "Seibun",
                                                      :six,       "Six",
                                                      :cinq,     "Cinq")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:seibun, "Seibun",
                                                      :six,       "Six",
                                                      :cinq,     "Cinq")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:quatre, "Quatre",
                                                      :trois,   "Trois",
                                                      :deux,     "Deux")
                       
        CardShuffler::ReasonAboutCards.dynamic_mode_switcher
      end
    end

    def self.scroll_of_healing
      CardShuffler::PredictCards.scroll_of_healing
      CardShuffler::ReasonAboutCards.scroll_of_healing
      
      2.times do
        CardShuffler::ReasonAboutCards.get_statistics(:esu,     "Esu",
                                                      :roi,     "Roi",
                                                      :reine, "Reine")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:jakku, "Jakku",
                                                      :dix,     "Dix",
                                                      :huit,   "Huit")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:seibun, "Seibun",
                                                      :six,       "Six",
                                                      :cinq,     "Cinq")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:seibun, "Seibun",
                                                      :six,       "Six",
                                                      :cinq,     "Cinq")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:quatre, "Quatre",
                                                      :trois,   "Trois",
                                                      :deux,     "Deux")
                       
        CardShuffler::ReasonAboutCards.dynamic_mode_switcher
      end
    end

    def self.scroll_of_poison
      CardShuffler::PredictCards.scroll_of_poison
      CardShuffler::ReasonAboutCards.scroll_of_poison
      
      2.times do
        CardShuffler::ReasonAboutCards.get_statistics(:esu,     "Esu",
                                                      :roi,     "Roi",
                                                      :reine, "Reine")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:jakku, "Jakku",
                                                      :dix,     "Dix",
                                                      :huit,   "Huit")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:seibun, "Seibun",
                                                      :six,       "Six",
                                                      :cinq,     "Cinq")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:seibun, "Seibun",
                                                      :six,       "Six",
                                                      :cinq,     "Cinq")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:quatre, "Quatre",
                                                      :trois,   "Trois",
                                                      :deux,     "Deux")
                       
        CardShuffler::ReasonAboutCards.dynamic_mode_switcher
      end
    end

    def self.scroll_of_stone
      CardShuffler::PredictCards.scroll_of_stone
      CardShuffler::ReasonAboutCards.scroll_of_stone
      
      2.times do
        CardShuffler::ReasonAboutCards.get_statistics(:esu,     "Esu",
                                                      :roi,     "Roi",
                                                      :reine, "Reine")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:jakku, "Jakku",
                                                      :dix,     "Dix",
                                                      :huit,   "Huit")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:seibun, "Seibun",
                                                      :six,       "Six",
                                                      :cinq,     "Cinq")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:seibun, "Seibun",
                                                      :six,       "Six",
                                                      :cinq,     "Cinq")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:quatre, "Quatre",
                                                      :trois,   "Trois",
                                                      :deux,     "Deux")
                       
        CardShuffler::ReasonAboutCards.dynamic_mode_switcher
      end
    end

    def self.scroll_of_death
      CardShuffler::PredictCards.scroll_of_death
      CardShuffler::ReasonAboutCards.scroll_of_death
      
      2.times do
        CardShuffler::ReasonAboutCards.get_statistics(:esu,     "Esu",
                                                      :roi,     "Roi",
                                                      :reine, "Reine")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:jakku, "Jakku",
                                                      :dix,     "Dix",
                                                      :huit,   "Huit")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:seibun, "Seibun",
                                                      :six,       "Six",
                                                      :cinq,     "Cinq")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:seibun, "Seibun",
                                                      :six,       "Six",
                                                      :cinq,     "Cinq")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:quatre, "Quatre",
                                                      :trois,   "Trois",
                                                      :deux,     "Deux")
                       
        CardShuffler::ReasonAboutCards.dynamic_mode_switcher
      end
    end

    def self.scroll_of_divinity
      CardShuffler::PredictCards.scroll_of_divinity
      CardShuffler::ReasonAboutCards.scroll_of_divinity
      
      2.times do
        CardShuffler::ReasonAboutCards.get_statistics(:esu,     "Esu",
                                                      :roi,     "Roi",
                                                      :reine, "Reine")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:jakku, "Jakku",
                                                      :dix,     "Dix",
                                                      :huit,   "Huit")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:seibun, "Seibun",
                                                      :six,       "Six",
                                                      :cinq,     "Cinq")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:seibun, "Seibun",
                                                      :six,       "Six",
                                                      :cinq,     "Cinq")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:quatre, "Quatre",
                                                      :trois,   "Trois",
                                                      :deux,     "Deux")
                       
        CardShuffler::ReasonAboutCards.dynamic_mode_switcher
      end
    end

    def self.scroll_of_binding
      CardShuffler::PredictCards.scroll_of_binding
      CardShuffler::ReasonAboutCards.scroll_of_binding
      
      2.times do
        CardShuffler::ReasonAboutCards.get_statistics(:esu,     "Esu",
                                                      :roi,     "Roi",
                                                      :reine, "Reine")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:jakku, "Jakku",
                                                      :dix,     "Dix",
                                                      :huit,   "Huit")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:seibun, "Seibun",
                                                      :six,       "Six",
                                                      :cinq,     "Cinq")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:seibun, "Seibun",
                                                      :six,       "Six",
                                                      :cinq,     "Cinq")
                       
        CardShuffler::ReasonAboutCards.dynamic_reward_allocation

        CardShuffler::ReasonAboutCards.get_statistics(:quatre, "Quatre",
                                                      :trois,   "Trois",
                                                      :deux,     "Deux")
                       
        CardShuffler::ReasonAboutCards.dynamic_mode_switcher
      end
    end
  end
end

module EnemyMechanics
  class MonsterIdentity
    ###################################################################################
    #                                Game Functions                                   #
    ###################################################################################
    def self.five_elements
      possible_elements = File.readlines("assets/monsternames/elements.txt")

      $chosen_element = possible_elements.sample.strip.to_s
    end

    def self.adjectives
      possible_adjectives = File.readlines("assets/monsternames/gendered_adverb.txt")

      $chosen_adjective = possible_adjectives.sample.strip.to_s 
    end

    def self.monster_name
      EnemyMechanics::MonsterIdentity.five_elements
      EnemyMechanics::MonsterIdentity.adjectives

      $current_monster_name = $chosen_element + " " + $chosen_adjective
    end
  end

  class OvertStats
    def self.get_statistics(a1, a2, b1, b2, c1, c2, d1, d2)
      a = a1, a2
      b = b1, b2
      c = c1, c2
      d = d1, d2

      matrix = [
        [[a[0], a[0], a[0], a[0]],
         [a[0], a[0], a[0], b[0]],
         [a[0], a[0], a[0], c[0]],
         [a[0], a[0], a[0], d[0]]],

       [[b[0], b[0], b[0], a[0]],
        [b[0], b[0], b[0], b[0]],
        [b[0], b[0], b[0], c[0]],
        [b[0], b[0], b[0], d[0]]],

       [[c[0], c[0], c[0], a[0]],
        [c[0], c[0], c[0], b[0]],
        [c[0], c[0], c[0], c[0]],
        [c[0], c[0], c[0], d[0]]],

       [[d[0], d[0], d[0], a[0]],
        [d[0], d[0], d[0], b[0]],
        [d[0], d[0], d[0], c[0]],
        [d[0], d[0], d[0], d[0]]],
     ], [
       [[a[1], a[1], a[1], a[1]],
        [a[1], a[1], a[1], b[1]],
        [a[1], a[1], a[1], c[1]],
        [a[1], a[1], a[1], d[1]]],

       [[b[1], b[1], b[1], a[1]],
        [b[1], b[1], b[1], b[1]],
        [b[1], b[1], b[1], c[1]],
        [b[1], b[1], b[1], d[1]]],

       [[c[1], c[1], c[1], a[1]],
        [c[1], c[1], c[1], b[1]],
        [c[1], c[1], c[1], c[1]],
        [c[1], c[1], c[1], d[1]]],

       [[d[1], d[1], d[1], a[1]],
        [d[1], d[1], d[1], b[1]],
        [d[1], d[1], d[1], c[1]],
        [d[1], d[1], d[1], d[1]]],
     ], [
       [[0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25]],

       [[0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25]],

       [[0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25]],

       [[0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25]],
     ]

     label_type       = matrix[0]
     definition_type  = matrix[1]
     probability_type = matrix[2]
  
     row_probability = 0.25
     col_probability = 0.25
  
     graph_selection = row_probability * col_probability

     row_options = [0, 1, 2, 3]
     col_options = [0, 1, 2, 3]
     arr_options = [0, 1, 2, 3]

     cur_row = row_options.sample
     cur_col = col_options.sample
     cur_arr = arr_options.sample
  
     current_label       = label_type[cur_row][cur_col][cur_arr]
     current_definition  = definition_type[cur_row][cur_col][cur_arr]
     current_probability = probability_type[cur_row][cur_col][cur_arr] * graph_selection
  
     "I'm confident it is not [ #{current_label} #{current_definition} ] as it has only #{current_probability} probability."
  
     $current_label       = current_label
     $current_probability = current_probability + current_probability
     $current_information = "#{current_label} #{current_definition}"
   end

    def self.reasses
      if $current_probability > 0.999999999999999999
        $current_probability = 0.9 / $current_probability
      end
   
      case $current_probability
      when 0.003921569000000000..0.287225000000000000
        puts"I'm confident it is not [ #{$current_information} ] because it has #{$current_probability}."
      when 0.287225000000000001..0.522225000000000000
        puts "I'm less unconfident it is not [ #{$current_information} ] because it has #{$current_probability}."
      when 0.522225000000000001..0.756112500000000000
        puts "I'm almost sure it is [ #{$current_information} ] because it has #{$current_probability}."
      when 0.756112500000000001..0.999999999999999999
        puts "I'm sure it is [ #{$current_information} ] because it has #{$current_probability}."

      else
        puts "The probability is either to low or to large, so I can't determine exactly."
      end
  
      $current_probability = $current_probability + $current_probability
    end

    def self.reconsider
      if $current_probability > 0.999999999999999999
        $current_probability = 0.9 / $current_probability
      end

      case $current_probability
      when 0.003921569000000000..0.287225000000000000
        puts "I'm confident it is not [ #{$current_information} ] because it has #{$current_probability}."
      when 0.287225000000000001..0.522225000000000000
        puts "I'm less unconfident it is not [ #{$current_information} ] because it has #{$current_probability}."
      when 0.522225000000000001..0.756112500000000000
        puts "I'm almost sure it is [ #{$current_information} ] because it has #{$current_probability}."
      when 0.756112500000000001..0.999999999999999999
        puts "I'm sure it is [ #{$current_information} ] because it has #{$current_probability}."
      else
        puts "The probability is either to low or to large, so I can't determine exactly."
      end
  
      old_probability      = $current_probability
      $current_probability = $current_probability / old_probability
    end

    def self.dynamic_reward_allocation
      l1_reasses = "level one reasses"
      l2_reasses = "level two reasses"
      l3_reasses = "level tre reasses"
      l4_reasses = "level fro reasses"

      reward_model = [
        [[l1_reasses, l1_reasses, l1_reasses, l1_reasses],
         [l1_reasses, l1_reasses, l1_reasses, l2_reasses],
         [l1_reasses, l1_reasses, l1_reasses, l3_reasses],
         [l1_reasses, l1_reasses, l1_reasses, l4_reasses]],
   
        [[l2_reasses, l2_reasses, l2_reasses, l1_reasses],
         [l2_reasses, l2_reasses, l2_reasses, l2_reasses],
         [l2_reasses, l2_reasses, l2_reasses, l3_reasses],
         [l2_reasses, l2_reasses, l2_reasses, l4_reasses]],
   
        [[l3_reasses, l3_reasses, l3_reasses, l1_reasses],
         [l3_reasses, l3_reasses, l3_reasses, l2_reasses],
         [l3_reasses, l3_reasses, l3_reasses, l3_reasses],
         [l3_reasses, l3_reasses, l3_reasses, l4_reasses]],
   
        [[l4_reasses, l4_reasses, l4_reasses, l1_reasses],
         [l4_reasses, l4_reasses, l4_reasses, l2_reasses],
         [l4_reasses, l4_reasses, l4_reasses, l3_reasses],
         [l4_reasses, l4_reasses, l4_reasses, l4_reasses]],
      ]

      row_options = [0, 1, 2, 3]
      col_options = [0, 1, 2, 3]
      arr_options = [0, 1, 2, 3]

      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample

      current_reward_structure = reward_model[cur_row][cur_col][cur_arr]
 
      if    current_reward_structure == l1_reasses; Gestate_L4::OvertStats.reasses
      elsif current_reward_structure == l2_reasses; 2.times do Gestate_L4::OvertStats.reasses end
      elsif current_reward_structure == l3_reasses; 3.times do Gestate_L4::OvertStats.reasses end
      elsif current_reward_structure == l4_reasses; 4.times do Gestate_L4::OvertStats.reasses end
      else
        reconsider
      end
    end

    def self.dynamic_guillotine_allocation
      l1_reasses = "level one reasses"
      l2_reasses = "level two reasses"
      l3_reasses = "level tre reasses"
      l4_reasses = "level fro reasses"

      reward_model = [
        [[l1_reasses, l1_reasses, l1_reasses, l1_reasses],
         [l1_reasses, l1_reasses, l1_reasses, l2_reasses],
         [l1_reasses, l1_reasses, l1_reasses, l3_reasses],
         [l1_reasses, l1_reasses, l1_reasses, l4_reasses]],
   
        [[l2_reasses, l2_reasses, l2_reasses, l1_reasses],
         [l2_reasses, l2_reasses, l2_reasses, l2_reasses],
         [l2_reasses, l2_reasses, l2_reasses, l3_reasses],
         [l2_reasses, l2_reasses, l2_reasses, l4_reasses]],
 
        [[l3_reasses, l3_reasses, l3_reasses, l1_reasses],
         [l3_reasses, l3_reasses, l3_reasses, l2_reasses],
         [l3_reasses, l3_reasses, l3_reasses, l3_reasses],
         [l3_reasses, l3_reasses, l3_reasses, l4_reasses]],
   
        [[l4_reasses, l4_reasses, l4_reasses, l1_reasses],
         [l4_reasses, l4_reasses, l4_reasses, l2_reasses],
         [l4_reasses, l4_reasses, l4_reasses, l3_reasses],
         [l4_reasses, l4_reasses, l4_reasses, l4_reasses]],
      ]

      row_options = [0, 1, 2, 3]
      col_options = [0, 1, 2, 3]
      arr_options = [0, 1, 2, 3]

      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample

      current_reward_structure = reward_model[cur_row][cur_col][cur_arr]
 
      if    current_reward_structure == l1_reasses; Gestate_L4::OvertStats.reconsider
      elsif current_reward_structure == l2_reasses; 2.times do Gestate_L4::OvertStats.reconsider end
      elsif current_reward_structure == l3_reasses; 3.times do Gestate_L4::OvertStats.reconsider end
      elsif current_reward_structure == l4_reasses; 4.times do Gestate_L4::OvertStats.reconsider end
      else
        reconsider
      end
    end

    def self.dynamic_mode_switcher
       modes = [
         [["deposit", "deposit"], ["deposit", "extract"]],
         [["extract", "deposit"], ["extract", "extract"]],
      ]
  
      row_options = [0, 1]
      col_options = [0, 1]
      arr_options = [0, 1]

      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample 

      current_mode = modes[cur_row][cur_col][cur_arr]

      if    current_mode == "deposit"; EnemyMechanics::OvertStats.dynamic_reward_allocation
      elsif current_mode == "extract"; EnemyMechanics::OvertStats.dynamic_guillotine_allocation
      else
        dynamic_guillotine_allocation
      end
    end
    
    def self.enemy_choice_tracker
      3.times do
        EnemyMechanics::OvertStats.gestate_l4(:lure, "is attempted on the main character.",
                                              :stun, "is attempted on the main character.",
                                              :trap, "is attempted on the main character.",
                                              :scan, "is attempted on the main character.")

        EnemyMechanics::OvertStats.dynamic_mode_switcher
        
        $cchoice = $current_label
        
        #thresholding($current_probability, 12, 12)
      end
    end

    ###################################################################################
    #                          Analyze Player Behaviours                              #
    ###################################################################################
    def self.analyze_player
      cchoice    = $cchoice
      player_def = $player_def
    
      previous_player_actions = File.readlines("data/player/previous_actions.txt")
      size_limit              = previous_player_actions.size.to_i
      index                   = 0
      
      size_limit.times do
        suspected_previous_actions = previous_player_action[index]

        if suspected_previous_actions == cchoice
          current_player_def = cette_int(player_def > 8) do
          
          puts "You managed to dodge the enemy's attack."
        end    

        current_player_def = maisette_int(current_player_def, player_def < 2) do
          puts "The enemy has strucky, but did not deal any damage..."
        end
      
        current_player_def = sinon_int(current_player_def) do
          puts "Damage to your person has been cut by half."
        
          $player_hp = $player - ($enemy_atk / 2 )
        end
      else
        puts "The enemy has missed their target."
      end

      sleep(1.5)
       
      index = index + 1
    end
  end
  
  class SubliminalStats
    def self.get_statistics(a1, a2, b1, b2, c1, c2, d1, d2)
      a = a1, a2
      b = b1, b2
      c = c1, c2
      d = d1, d2

      matrix = [
        [[a[0], a[0], a[0], a[0]],
         [a[0], a[0], a[0], b[0]],
         [a[0], a[0], a[0], c[0]],
         [a[0], a[0], a[0], d[0]]],

       [[b[0], b[0], b[0], a[0]],
        [b[0], b[0], b[0], b[0]],
        [b[0], b[0], b[0], c[0]],
        [b[0], b[0], b[0], d[0]]],

       [[c[0], c[0], c[0], a[0]],
        [c[0], c[0], c[0], b[0]],
        [c[0], c[0], c[0], c[0]],
        [c[0], c[0], c[0], d[0]]],

       [[d[0], d[0], d[0], a[0]],
        [d[0], d[0], d[0], b[0]],
        [d[0], d[0], d[0], c[0]],
        [d[0], d[0], d[0], d[0]]],
     ], [
       [[a[1], a[1], a[1], a[1]],
        [a[1], a[1], a[1], b[1]],
        [a[1], a[1], a[1], c[1]],
        [a[1], a[1], a[1], d[1]]],

       [[b[1], b[1], b[1], a[1]],
        [b[1], b[1], b[1], b[1]],
        [b[1], b[1], b[1], c[1]],
        [b[1], b[1], b[1], d[1]]],

       [[c[1], c[1], c[1], a[1]],
        [c[1], c[1], c[1], b[1]],
        [c[1], c[1], c[1], c[1]],
        [c[1], c[1], c[1], d[1]]],

       [[d[1], d[1], d[1], a[1]],
        [d[1], d[1], d[1], b[1]],
        [d[1], d[1], d[1], c[1]],
        [d[1], d[1], d[1], d[1]]],
     ], [
       [[0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25]],

       [[0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25]],

       [[0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25]],

       [[0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25],
        [0.25, 0.25, 0.25, 0.25]],
     ]

     label_type       = matrix[0]
     definition_type  = matrix[1]
     probability_type = matrix[2]
  
     row_probability = 0.25
     col_probability = 0.25
  
     graph_selection = row_probability * col_probability

     row_options = [0, 1, 2, 3]
     col_options = [0, 1, 2, 3]
     arr_options = [0, 1, 2, 3]

     cur_row = row_options.sample
     cur_col = col_options.sample
     cur_arr = arr_options.sample
  
     current_label       = label_type[cur_row][cur_col][cur_arr]
     current_definition  = definition_type[cur_row][cur_col][cur_arr]
     current_probability = probability_type[cur_row][cur_col][cur_arr] * graph_selection
  
     "I'm confident it is not [ #{current_label} #{current_definition} ] as it has only #{current_probability} probability."
  
     $current_label       = current_label
     $current_probability = current_probability + current_probability
     $current_information = "#{current_label} #{current_definition}"
   end

    def self.reasses
      if $current_probability > 0.999999999999999999
        $current_probability = 0.9 / $current_probability
      end
   
      case $current_probability
      when 0.003921569000000000..0.287225000000000000
        "I'm confident it is not [ #{$current_information} ] because it has #{$current_probability}."
      when 0.287225000000000001..0.522225000000000000
        "I'm less unconfident it is not [ #{$current_information} ] because it has #{$current_probability}."
      when 0.522225000000000001..0.756112500000000000
        "I'm almost sure it is [ #{$current_information} ] because it has #{$current_probability}."
      when 0.756112500000000001..0.999999999999999999
        "I'm sure it is [ #{$current_information} ] because it has #{$current_probability}."

      else
        puts "The probability is either to low or to large, so I can't determine exactly."
      end
  
      $current_probability = $current_probability + $current_probability
    end

    def self.reconsider
      if $current_probability > 0.999999999999999999
        $current_probability = 0.9 / $current_probability
      end

      case $current_probability
      when 0.003921569000000000..0.287225000000000000
        "I'm confident it is not [ #{$current_information} ] because it has #{$current_probability}."
      when 0.287225000000000001..0.522225000000000000
        "I'm less unconfident it is not [ #{$current_information} ] because it has #{$current_probability}."
      when 0.522225000000000001..0.756112500000000000
        "I'm almost sure it is [ #{$current_information} ] because it has #{$current_probability}."
      when 0.756112500000000001..0.999999999999999999
        "I'm sure it is [ #{$current_information} ] because it has #{$current_probability}."
      else
        puts "The probability is either to low or to large, so I can't determine exactly."
      end
  
      old_probability      = $current_probability
      $current_probability = $current_probability / old_probability
    end

    def self.dynamic_reward_allocation
      l1_reasses = "level one reasses"
      l2_reasses = "level two reasses"
      l3_reasses = "level tre reasses"
      l4_reasses = "level fro reasses"

      reward_model = [
        [[l1_reasses, l1_reasses, l1_reasses, l1_reasses],
         [l1_reasses, l1_reasses, l1_reasses, l2_reasses],
         [l1_reasses, l1_reasses, l1_reasses, l3_reasses],
         [l1_reasses, l1_reasses, l1_reasses, l4_reasses]],
   
        [[l2_reasses, l2_reasses, l2_reasses, l1_reasses],
         [l2_reasses, l2_reasses, l2_reasses, l2_reasses],
         [l2_reasses, l2_reasses, l2_reasses, l3_reasses],
         [l2_reasses, l2_reasses, l2_reasses, l4_reasses]],
   
        [[l3_reasses, l3_reasses, l3_reasses, l1_reasses],
         [l3_reasses, l3_reasses, l3_reasses, l2_reasses],
         [l3_reasses, l3_reasses, l3_reasses, l3_reasses],
         [l3_reasses, l3_reasses, l3_reasses, l4_reasses]],
   
        [[l4_reasses, l4_reasses, l4_reasses, l1_reasses],
         [l4_reasses, l4_reasses, l4_reasses, l2_reasses],
         [l4_reasses, l4_reasses, l4_reasses, l3_reasses],
         [l4_reasses, l4_reasses, l4_reasses, l4_reasses]],
      ]

      row_options = [0, 1, 2, 3]
      col_options = [0, 1, 2, 3]
      arr_options = [0, 1, 2, 3]

      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample

      current_reward_structure = reward_model[cur_row][cur_col][cur_arr]
 
      if    current_reward_structure == l1_reasses; EnemyMechanics::SubliminalStats.reasses
      elsif current_reward_structure == l2_reasses; 2.times do EnemyMechanics::SubliminalStats.reasses end
      elsif current_reward_structure == l3_reasses; 3.times do EnemyMechanics::SubliminalStats.reasses end
      elsif current_reward_structure == l4_reasses; 4.times do EnemyMechanics::SubliminalStats.reasses end
      else
        reconsider
      end
    end

    def self.dynamic_guillotine_allocation
      l1_reasses = "level one reasses"
      l2_reasses = "level two reasses"
      l3_reasses = "level tre reasses"
      l4_reasses = "level fro reasses"

      reward_model = [
        [[l1_reasses, l1_reasses, l1_reasses, l1_reasses],
         [l1_reasses, l1_reasses, l1_reasses, l2_reasses],
         [l1_reasses, l1_reasses, l1_reasses, l3_reasses],
         [l1_reasses, l1_reasses, l1_reasses, l4_reasses]],
   
        [[l2_reasses, l2_reasses, l2_reasses, l1_reasses],
         [l2_reasses, l2_reasses, l2_reasses, l2_reasses],
         [l2_reasses, l2_reasses, l2_reasses, l3_reasses],
         [l2_reasses, l2_reasses, l2_reasses, l4_reasses]],
 
        [[l3_reasses, l3_reasses, l3_reasses, l1_reasses],
         [l3_reasses, l3_reasses, l3_reasses, l2_reasses],
         [l3_reasses, l3_reasses, l3_reasses, l3_reasses],
         [l3_reasses, l3_reasses, l3_reasses, l4_reasses]],
   
        [[l4_reasses, l4_reasses, l4_reasses, l1_reasses],
         [l4_reasses, l4_reasses, l4_reasses, l2_reasses],
         [l4_reasses, l4_reasses, l4_reasses, l3_reasses],
         [l4_reasses, l4_reasses, l4_reasses, l4_reasses]],
      ]

      row_options = [0, 1, 2, 3]
      col_options = [0, 1, 2, 3]
      arr_options = [0, 1, 2, 3]

      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample

      current_reward_structure = reward_model[cur_row][cur_col][cur_arr]
 
      if    current_reward_structure == l1_reasses; reconsider
      elsif current_reward_structure == l2_reasses; 2.times do EnemyMechanics::SubliminalStats.reconsider end
      elsif current_reward_structure == l3_reasses; 3.times do EnemyMechanics::SubliminalStats.reconsider end
      elsif current_reward_structure == l4_reasses; 4.times do EnemyMechanics::SubliminalStats.reconsider end
      else
        reconsider
      end
    end

    def self.dynamic_mode_switcher
       modes = [
         [["deposit", "deposit"], ["deposit", "extract"]],
         [["extract", "deposit"], ["extract", "extract"]],
      ]
  
      row_options = [0, 1]
      col_options = [0, 1]
      arr_options = [0, 1]

      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample 

      current_mode = modes[cur_row][cur_col][cur_arr]

      if    current_mode == "deposit"; EnemyMechanics::SubliminalStats.dynamic_reward_allocation
      elsif current_mode == "extract"; EnemyMechanics::SubliminalStats.dynamic_guillotine_allocation
      else
        dynamic_guillotine_allocation
      end
    end
    
    ###################################################################################
    #                          Analyze Player Behaviours                              #
    ###################################################################################
    def self.analyze_player
      cchoice    = $cchoice
      player_def = $player_def
    
      previous_player_actions = File.readlines("data/player/previous_actions.txt")
      size_limit              = previous_player_actions.size.to_i
      index                   = 0
      
      size_limit.times do
        suspected_previous_actions = previous_player_action[index]

        if suspected_previous_actions == cchoice
          current_player_def = cette_int(player_def > 8) do
          
          puts "You managed to dodge the enemy's attack."
        end    

        current_player_def = maisette_int(current_player_def, player_def < 2) do
          puts "The enemy has strucky, but did not deal any damage..."
        end
      
        current_player_def = sinon_int(current_player_def) do
          puts "Damage to your person has been cut by half."
        
          $player_hp = $player - ($enemy_atk / 2 )
        end
      else
        puts "The enemy has missed their target."
      end

      sleep(1.5)
       
      index = index + 1
    end
  end
    
  class EnemyTrackers
    def self.contrast_enemy
      enemy_hp  = $enemy_hp
  
      ## Analyze current enemy life points
      compared_e_count = cette_int(enemy_hp <= 2) do
        puts "#{monster_name} is in critical condition."
      end

      compared_e_count = maisette_int(compared_e_count, enemy_hp >= 8) do
        puts "#{monster_name} is in very good condition."
      end

      compared_e_count = sinon_int(compared_e_count) do
        puts "The enemy is currently fluctuating stability at: #{enemy_hp}."
      end
    end
  
    def self.enemy_hp_tracker
      enemy_hp = $enemy_hp
    
      current_enemy_hp = cette_int(enemy_hp > 8) do
        puts "The enemy is currently in good shape..."
      end
      
      current_enemy_hp = maisette_int(enemy_hp > 2) do
        puts "The enemy is currently on life support..."
      end

      current_enemy_hp = sinon_int(current_enemy_hp) do
        puts "You should still be mindful as the enemy is still a threat."
      end
    end

    def self.enemy_atk_tracker
      enemy_atk = $enemy_atk
    
      current_enemy_atk = cette_int(enemy_atk > 8) do
        puts "The enemy has enough energy to do significant damage..."
      end
      
      current_enemy_atk = maisette_int(enemy_atk > 2) do
        puts "The enemy is currently in a weakened state..."
      end

      current_enemy_atk = sinon_int(current_enemy_atk) do
        puts "You should still be mindful as the enemy can still deal significant damage."
      end
    end
    
    def self.enemy_choice_tracker
      3.times do
        EnemyMechanics::SubliminalStats.get_statistics(:lure, "is attempted on the main character.",
                                                       :stun, "is attempted on the main character.",
                                                       :trap, "is attempted on the main character.",
                                                       :scan, "is attempted on the main character.")

        EnemyMechanics::SubliminalStats.dynamic_mode_switcher
        
        $cchoice = $current_label
        
        #thresholding($current_probability, 12, 12)
      end
    end
  end
  
  class BeastTrackers
    #########################################################################################################
    #                                           Beast Trackers                                              #
    #########################################################################################################
    def self.monitor_acid_dragons
      puts "[ Acid Dragons: #{$acid_dragons} ]"

      compared_dra_count = cette_int($acid_dragons <= 2) do
        f.puts "The amount of acid dragons in the world is in decline."
      end

      compared_dra_count = maisette_int(compared_dra_count, $acid_dragons >= 8) do
        f.puts "There is a surplus of acid dragons in the acidic ocean."
      end

      compared_dra_count = sinon_int(compared_dra_count) do
        f.puts "Be careful as there may still be acid dragons."
      end
    end

    def self.monitor_sea_gargoyals
      puts "[ Sea Gargoyals: #{$sea_gargoyals} ]"

      compared_gar_count = cette_int($sea_gargoyals <= 4) do
        f.puts "The amount of sea gargoyals in the world is in decline."
      end

      compared_gar_count = maisette_int(compared_gar_count, $sea_gargoyals >= 15) do
        f.puts "There is a surplus of sea gargoyals in the guard post of the ancient temple."
      end

      compared_gar_count = sinon_int(compared_gar_count) do
        f.puts "Be careful as there may still be sea gargoyals."
      end
    end

    def self.monitor_acid_serpents
      puts "[ Acid Serpents: #{$acid_serpents} ]"

      compared_ser_count = cette_int($sea_gargoyals <= 5) do
        f.puts "The amount of acid serpents in the world is in decline."
      end

      compared_ser_count = maisette_int(compared_ser_count, $sea_gargoyals >= 21) do
        f.puts "There is a surplus of acid serpents in the guard post of the ancient temple."
      end

      compared_ser_count = sinon_int(compared_ser_count) do
        f.puts "Be careful as there may still be acid serpents."
      end
    end

    def self.monitor_traitorous_nuns
      puts "[ Traitorous Nuns: #{$traitorous_nuns} ]"

      compared_nun_count = cette_int($traitorous_nuns <= 4) do
        f.puts "The amount of traitorous nuns in the world is in decline."
      end

      compared_nun_count = maisette_int(compared_nun_count, $traitorous_nuns >= 15) do
        f.puts "There is a surplus of traitorous nuns in the guard post of the ancient temple."
      end

      compared_nun_count = sinon_int(compared_nun_count) do
        f.puts "Be careful as there may still be traitorous."
      end
    end
  end
end

module NPCBehaviours
  class Language
    ################################################################################################
    #                               Procedural Dialogue Generation                                 #
    ################################################################################################
    def self.npc_dialogue
      word_classes = [
        [
          [["Le",  "Le"], ["Le",  "La"], ["Le",  "Les"]],
          [["La",  "Le"], ["La",  "La"], ["La",  "Les"]],
          [["Les", "Le"], ["Les", "La"], ["Les", "Les"]],
        ], [
          [["Anu",  "Anu"], ["Anu",  "Ana"], ["Anu",  "Anos"]],
          [["Ana",  "Anu"], ["Ana",  "Ana"], ["Ana",  "Anos"]],
          [["Anos", "Anu"], ["Anos", "Ana"], ["Anos", "Anus"]],
        ], [
          [["Lanu",  "Lanu"], ["Lanu",  "Lana"], ["Lanu",  "Lanos"]],
          [["Lana",  "Lanu"], ["Lana",  "Lana"], ["Lana",  "Lanos"]],
          [["Lanos", "Lanu"], ["Lanos", "Lana"], ["Lanos", "Lanos"]],
        ],
      ]

      context_window = [0, 1, 2]
      row_options    = [0, 1, 2]
      col_options    = [0, 1, 2]
      arr_options    = [0, 1]

      cur_con = context_window.sample
      cur_row =    row_options.sample
      cur_col =    col_options.sample
      cur_arr =    arr_options.sample

      @current_word_class = word_classes[cur_con][cur_row][cur_col][cur_arr]
      #print current_word_class; print " "

      ho   = "homme"
      fe   = "femme"
      fi   = "fille"
      ga   = "garcon"
      ta   = "tante"
      oj   = "oncle"
      cofi = "cousinfille"
      coga = "cousingarcon"
      grm  = "grandmere"
      grp  = "grandpere"

      ct   = "chat"
      ch   = "chien"
      oi   = "oiseau"
      gr   = "souris"
      ou   = "ours"
      wo   = "orgueil"
      pr   = "ostritch"
      po   = "jiraff"
      pi   = "écureuil"

      m    = "maison"
      c    = "cabin"
      e    = "ecole"

      oju  = "ojijaku"
      neo  = "ne ojijaku"

      nouns = [
        [[ho,   ho], [ho,   fe], [ho,   fi], [ho,   ga], [ho,   ta], [ho,   oj], [ho,   cofi], [ho,   coga], [ho,   grm], [ho,   grp]],
        [[fe,   ho], [fe,   fe], [fe,   fi], [fe,   ga], [fe,   ta], [fe,   oj], [fe,   cofi], [fe,   coga], [fe,   grm], [fe,   grp]],
        [[fi,   ho], [fi,   fe], [fi,   fi], [fi,   ga], [fi,   ta], [fi,   oj], [fi,   cofi], [fi,   coga], [fi,   grm], [fi,   grp]],
        [[ga,   ho], [ga,   fe], [ga,   fi], [ga,   ga], [ga,   ta], [ga,   oj], [ga,   cofi], [ga,   coga], [ga,   grm], [ga,   grp]],
        [[ta,   ho], [ta,   fe], [ta,   fi], [ta,   ga], [ta,   ta], [ta,   oj], [ta,   cofi], [ta,   coga], [ta,   grm], [ta,   grp]],
        [[oj,   ho], [oj,   fe], [oj,   fi], [oj,   ga], [oj,   ta], [oj,   oj], [oj,   cofi], [oj,   coga], [oj,   grm], [oj,   grp]],
        [[cofi, ho], [cofi, fe], [cofi, fi], [cofi, ga], [cofi, ta], [cofi, oj], [cofi, cofi], [cofi, coga], [cofi, grm], [cofi, grp]],
        [[coga, ho], [coga, fe], [coga, fi], [coga, ga], [coga, ta], [coga, oj], [coga, cofi], [coga, coga], [coga, grm], [coga, grp]],
        [[grm,  ho], [grm,  fe], [grm,  fi], [grm,  ga], [grm,  ta], [grm,  oj], [grm,  cofi], [grm,  coga], [grm,  grm], [grm,  grp]],
        [[grp,  ho], [grp,  fe], [grp,  fi], [grp,  ga], [grp,  ta], [grp,  oj], [grp,  cofi], [grp,  coga], [grp,  grm], [grp,  grp]],
      ], [
        [[ct, ct], [ct, ch], [ct, oi], [ct, gr], [ct, wo], [ct, ou], [ct, pr], [ct, po]],
        [[ch, ct], [ch, ch], [ch, oi], [ch, gr], [ch, wo], [ch, ou], [ch, pr], [ch, po]],
        [[oi, ct], [oi, ch], [oi, oi], [pi, gr], [oi, wo], [oi, ou], [oi, pr], [oi, po]],
        [[gr, ct], [gr, ch], [gr, oi], [gr, gr], [gr, wo], [gr, ou], [gr, pr], [gr, po]],
      ], [
        [[m, m], [m, c], [m, e]],
        [[c, m], [c, c], [c, e]],
        [[e, m], [e, c], [e, e]],
      ], [
        [[oju, oju], [oju, neo]],
        [[neo, oju], [neo, neo]],
      ]

      context_window = [0, 1, 2, 3]
      cur_con        = context_window.sample

      if    cur_con == 0
        row_options    = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        col_options    = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        arr_options    = [0, 1]

        #cur_con = context_window.sample
        cur_row =    row_options.sample
        cur_col =    col_options.sample
        cur_arr =    arr_options.sample

        @current_noun = nouns[cur_con][cur_row][cur_col][cur_arr]
        #print current_noun; print " "

      elsif cur_con == 1
        row_options    = [0, 1, 2, 3]
        col_options    = [0, 1, 2, 3]
        arr_options    = [0, 1]

        #cur_con = context_window.sample
        cur_row =    row_options.sample
        cur_col =    col_options.sample
        cur_arr =    arr_options.sample

        @current_noun = nouns[cur_con][cur_row][cur_col][cur_arr]
        #print current_noun; print " "
      elsif cur_con == 2
        row_options    = [0, 1, 2]
        col_options    = [0, 1, 2]
        arr_options    = [0, 1]

        #cur_con = context_window.sample
        cur_row =    row_options.sample
        cur_col =    col_options.sample
        cur_arr =    arr_options.sample

        @current_noun = nouns[cur_con][cur_row][cur_col][cur_arr]
      elsif cur_con == 3
        row_options    = [0, 1]
        col_options    = [0, 1]
        arr_options    = [0, 1]

        #cur_con = context_window.sample
        cur_row =    row_options.sample
        cur_col =    col_options.sample
        cur_arr =    arr_options.sample

        @current_noun = nouns[cur_con][cur_row][cur_col][cur_arr]
        #print current_noun; print " "
      end

      subjects = [
        [["es",    "es"], ["es",    "es ne"]],
        [["es ne", "es"], ["es ne", "es ne"]],
      ], [
        [["es",    "es"], ["es",    "es ne"]],
        [["es ne", "es"], ["es ne", "es ne"]],
      ]

      context_window = [0, 1]

      row_options    = [0, 1]
      col_options    = [0, 1]
      arr_options    = [0, 1]

      cur_con = context_window.sample
      cur_row =    row_options.sample
      cur_col =    col_options.sample
      cur_arr =    arr_options.sample

      @current_subject = subjects[cur_con][cur_row][cur_col][cur_arr]
      #print current_subject; print " "

      avo = "avoir"
      cou = "coupe"
      ser = "serrure"
      dev = "déverrouillage"

      verbs = [
        [[avo, avo], [avo, cou], [avo, ser], [avo, dev]],
        [[cou, avo], [cou, cou], [cou, ser], [cou, dev]],
        [[ser, avo], [ser, cou], [ser, ser], [ser, dev]],
        [[dev, avo], [dev, cou], [dev, ser], [dev, dev]],
      ], [
        [[cou, avo], [cou, cou], [cou, ser], [cou, dev]],
        [[ser, avo], [ser, cou], [ser, ser], [ser, dev]],
        [[dev, avo], [dev, cou], [dev, ser], [dev, dev]],
        [[avo, avo], [avo, cou], [avo, ser], [avo, dev]],
      ], [
        [[ser, avo], [ser, cou], [ser, ser], [ser, dev]],
        [[dev, avo], [dev, cou], [dev, ser], [dev, dev]],
        [[avo, avo], [avo, cou], [avo, ser], [avo, dev]],
        [[cou, avo], [cou, cou], [cou, ser], [cou, dev]],
      ], [
        [[dev, avo], [dev, cou], [dev, ser], [dev, dev]],
        [[avo, avo], [avo, cou], [avo, ser], [avo, dev]],
        [[cou, avo], [cou, cou], [cou, ser], [cou, dev]],
        [[ser, avo], [ser, cou], [ser, ser], [ser, dev]],
      ]

      context_window = [0, 1, 2, 3]
      row_options    = [0, 1, 2, 3]
      col_options    = [0, 1, 2, 3]
      arr_options    = [0, 1]

      cur_con = context_window.sample
      cur_row =    row_options.sample
      cur_col =    col_options.sample
      cur_arr =    arr_options.sample

      @current_verb = verbs[cur_con][cur_row][cur_col][cur_arr]

      "#{@current_word_class} #{@current_noun} #{@current_subject} #{@current_verb}."
    end

    def self.contrastive_dialogue
      ## The Call
      ##           la pomme  la banane  le granit
      ## la pomme  p,p       p,b        p,g
      ## la banane b,p       b,b        b,g
      ## le grenit g,p       g,b        g,g

      gendered_nouns_set1      = [
        [["Cette pomme",  "Cette pomme"], ["Cette pomme",  "Cette banane"], ["Cette pomme",  "Cette granit"]],
        [["Cette banane", "Cette pomme"], ["Cette banane", "Cette banane"], ["Cette banane", "Cette granit"]],
        [["Cette granit", "Cette pomme"], ["Cette granit", "Cette banane"], ["Cette granit", "Cette granit"]],
      ]

      gns1_row_options = [0, 1, 2]
      gns1_col_options = [0, 1, 2]
      gns1_arr_options = [0, 1]

      gns1_cur_row = gns1_row_options.sample
      gns1_cur_col = gns1_col_options.sample
      gns1_cur_arr = gns1_arr_options.sample

      gns1 = gendered_nouns_set1[gns1_cur_row][gns1_cur_col][gns1_cur_arr]

      #        rouge jaune violet
      # rouge  r,r   r,j   r,v
      # jaune  j,r   j,j   j,v
      # violet v,r   v,j   v,v

      adjectives_set1          = [
        [["rouge",  "rouge"], ["rouge",  "jaune"], ["rouge",  "violet"]],
        [["jaune",  "rouge"], ["jaune",  "jaune"], ["jaune",  "violet"]],
        [["violet", "rouge"], ["violet", "jaune"], ["violet", "violet"]],
      ]

      as1_row_options = [0, 1, 2]
      as1_col_options = [0, 1, 2]
      as1_arr_options = [0, 1]

      as1_cur_row = as1_row_options.sample
      as1_cur_col = as1_col_options.sample
      as1_cur_arr = as1_arr_options.sample

      as1 = adjectives_set1[as1_cur_row][as1_cur_col][as1_cur_arr]

      #              je mange  je ne mange je jute  je ne jute
      # je mange     jm, jm    jm, jnm     jm, jj   jm,jnj
      # je ne mange  jnm, jm   jnm, jnm    jnm, jj  jnm, jnj
      # je jute      jj, jm    jj, jnm     jj, jj   jj, jnj
      # je ne jute   jnj, jm   jnj, jnm    jnj, jj  jnj, jnj

      subjective_verbs_set1    = [
        [ ["Je mange",    "Je mange"], ["Je mange",    "Je ne mange"], ["Je mange",    "Je jute"], ["Je mange",    "Je ne jute"]],
        [ ["Je ne mange", "Je mange"], ["Je ne mange", "Je ne mange"], ["Je ne mange", "Je jute"], ["Je ne mange", "Je ne jute"]],
        [ ["Je jute",     "Je mange"], ["Je jute",     "Je ne mange"], ["Je jute",     "Je jute"], ["Je jute",     "Je ne jute"]],
        [ ["Je ne jute",  "Je mange"], ["Je ne jute",  "Je ne mange"], ["Je ne jute",  "Je jute"], ["Je ne jute",  "Je ne jute"]],
      ]

      svs1_row_options = [0, 1, 2, 3]
      svs1_col_options = [0, 1, 2, 3]
      svs1_arr_options = [0, 1]

      svs1_cur_row = svs1_row_options.sample
      svs1_cur_col = svs1_col_options.sample
      svs1_cur_arr = svs1_arr_options.sample

      svs1 = subjective_verbs_set1[svs1_cur_row][svs1_cur_col][svs1_cur_arr]

      #            lentiment quicely
      # lentement  l,l       l,q
      # quicely    q,l       q,q

      adverb_punctuation_set1  = [
        [["lentement,", "lentement,"], ["lentement,", "quicely,"]],
        [["quicely,",   "lentement,"], ["quicely,",   "quicely,"]],
      ]

      aps1_row_options = [0, 1]
      aps1_col_options = [0, 1]
      aps1_arr_options = [0, 1]

      aps1_cur_row = aps1_row_options.sample
      aps1_cur_col = aps1_col_options.sample
      aps1_cur_arr = aps1_arr_options.sample

      aps1 = adverb_punctuation_set1[aps1_cur_row][aps1_cur_col][aps1_cur_arr]

      ## The Responce
      gendered_nouns_set2      = [
        [["mais cette pomme",        "mais cette pomme"], ["mais cette pomme",  "mais cette banane"], ["mais cette pomme",  "mais cette granit"]],
        [["mais cette la banane", "mais cette la pomme"], ["mais cette banane", "mais cette banane"], ["mais cette banane", "mais cette granit"]],
        [["mais cette le granit", "mais cette la pomme"], ["mais cette granit", "mais cette banane"], ["mais cette granit", "mais cette granit"]],
      ]

      gns2_row_options = [0, 1, 2]
      gns2_col_options = [0, 1, 2]
      gns2_arr_options = [0, 1]

      gns2_cur_row = gns2_row_options.sample
      gns2_cur_col = gns2_col_options.sample
      gns2_cur_arr = gns2_arr_options.sample

      gns2 = gendered_nouns_set2[gns2_cur_row][gns2_cur_col][gns2_cur_arr]

      adjectives_set2          = [
        [["rouge",  "rouge"], ["rouge",  "jaune"], ["rouge",  "violet"]],
        [["jaune",  "rouge"], ["jaune",  "jaune"], ["jaune",  "violet"]],
        [["violet", "rouge"], ["violet", "jaune"], ["violet", "violet"]],
      ]

      as2_row_options = [0, 1, 2]
      as2_col_options = [0, 1, 2]
      as2_arr_options = [0, 1]

      as2_cur_row = as2_row_options.sample
      as2_cur_col = as2_col_options.sample
      as2_cur_arr = as2_arr_options.sample

      as2 = adjectives_set2[as2_cur_row][as2_cur_col][as2_cur_arr]

      subjective_verbs_set2    = [
        [["Je mange",    "Je mange"], ["Je mange",    "Je ne mange"], ["Je mange",    "Je jute"], ["Je mange",    "Je ne jute"]],
        [["Je ne mange", "Je mange"], ["Je ne mange", "Je ne mange"], ["Je ne mange", "Je jute"], ["Je ne mange", "Je ne jute"]],
        [["Je jute",     "Je mange"], ["Je jute",     "Je ne mange"], ["Je jute",     "Je jute"], ["Je jute",     "Je ne jute"]],
        [["Je ne jute",  "Je mange"], ["Je ne jute",  "Je ne mange"], ["Je ne jute",  "Je jute"], ["Je ne jute",  "Je ne jute"]],
      ]

      svs2_row_options = [0, 1, 2, 3]
      svs2_col_options = [0, 1, 2, 3]
      svs2_arr_options = [0, 1]

      svs2_cur_row = svs2_row_options.sample
      svs2_cur_col = svs2_col_options.sample
      svs2_cur_arr = svs2_arr_options.sample

      svs2 = subjective_verbs_set2[svs2_cur_row][svs2_cur_col][svs2_cur_arr]

      adverb_punctuation_set2 = [
        [["lentement.", "lentement."], ["lentement.", "quicely."]],
        [["quicely.",   "lentement."], ["quicely.",   "quicely."]],
      ]

      aps2_row_options = [0, 1]
      aps2_col_options = [0, 1]
      aps2_arr_options = [0, 1]

      aps2_cur_row = aps2_row_options.sample
      aps2_cur_col = aps2_col_options.sample
      aps2_cur_arr = aps2_arr_options.sample

      aps2 = adverb_punctuation_set2[aps2_cur_row][aps2_cur_col][aps2_cur_arr]

      ## Generates the actual training data.
      phrase = "#{gns1} #{as1} #{svs1} #{aps1} #{gns2} #{as2} #{svs2} #{aps2}"

      phrase
    end

    def self.lingua_de_ange
      a = "He"
      b = "Hu"
      c = "Hosfa"

      word_genders = [
        [[a, a, a], [a, a, b], [a, a, c]],
        [[b, b, a], [b, b, b], [b, b, c]],
        [[c, c, a], [c, c, b], [c, c, c]],
      ]

      row_options = [0, 1, 2]
      col_options = [0, 1, 2]
      arr_options = [0, 1, 2]

      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample

      current_gender = word_genders[cur_row][cur_col][cur_arr]

      d = "powe"     # pomme
      e = "bau aue"  # banane
      f = "seterone" # citrone

      nouns = [
        [[d, d, d], [d, d, e], [d, d, f]],
        [[e, e, d], [e, e, e], [e, e, f]],
        [[f, f, d], [f, f, e], [f, f, f]],
      ]

      row_options = [0, 1, 2]
      col_options = [0, 1, 2]
      arr_options = [0, 1, 2]

      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample

      current_noun = nouns[cur_row][cur_col][cur_arr]

      g = "rouge"  # rouge
      h = "vedute" # vert
      i = "na une" # jaune

      adjectives = [
        [[g, g, g], [g, g, h], [g, g, i]],
        [[h, h, g], [h, h, h], [h, h, i]],
        [[i, i, g], [i, i, h], [i, i, i]],
      ]

      row_options = [0, 1, 2]
      col_options = [0, 1, 2]
      arr_options = [0, 1, 2]

      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample

      current_adjective = adjectives[cur_row][cur_col][cur_arr]

      j =   "ne" # je
      k = "vuse" # vous
      l =   "tu" # tu
      m = "nuse" # nous
      n =  "eye" # elle
      o =  "ehe" # il

      subjects = [
        [[j, j, j, j, j],
         [j, j, j, j, k],
         [j, j, j, j, l],
         [j, j, j, j, m],
         [j, j, j, j, n],
         [j, j, j, j, o]],

        [[k, k, k, k, j],
         [k, k, k, k, k],
         [k, k, k, k, l],
         [k, k, k, k, m],
         [k, k, k, k, n],
         [k, k, k, k, o]],

        [[l, l, l, l, j],
         [l, l, l, l, k],
         [l, l, l, l, l],
         [l, l, l, l, m],
         [l, l, l, l, n],
         [l, l, l, l, o]],

        [[m, m, m, m, j],
         [m, m, m, m, k],
         [m, m, m, m, l],
         [m, m, m, m, m],
         [m, m, m, m, n],
         [m, m, m, m, o]],

        [[n, n, n, n, j],
         [n, n, n, n, k],
         [n, n, n, n, l],
         [n, n, n, n, m],
         [n, n, n, n, n],
         [n, n, n, n, o]],

        [[o, o, o, o, j],
         [o, o, o, o, k],
         [o, o, o, o, l],
         [o, o, o, o, m],
         [o, o, o, o, n],
         [o, o, o, o, o]],
      ]

      row_options = [0, 1, 2, 3, 4]
      col_options = [0, 1, 2, 3, 4]
      arr_options = [0, 1, 2, 3, 4]

      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample

      current_subjects = subjects[cur_row][cur_col][cur_arr]

      p =    "bode" # boire
      q = "emanage" # mange
      r =    "nute" # jute

      verbs = [
        [[p, p, p], [p, p, q], [p, p, r]],
        [[q, q, p], [q, q, q], [q, q, r]],
        [[r, r, p], [r, r, q], [r, r, r]],
      ]

      row_options = [0, 1, 2]
      col_options = [0, 1, 2]
      arr_options = [0, 1, 2]

      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample

      current_verbs = verbs[cur_row][cur_col][cur_arr]

      "#{current_gender} #{current_noun} #{current_adjective} #{current_subjects} #{current_verbs}"
    end

    def self.monitor_dialogue
      require "MaisettelinguaLite"

      player_sanity = $player_sanity
      player_name   = "SARAH"

      current_sanity = cette_int(player_sanity < 2) do
        #puts "BIANCA: You slipped past the critical threshold for sanity."
  
        puts "#{player_name}: "
        lingua_de_ange
      end

      current_sanity = maisette_int(current_sanity, player_sanity > 8) do
        #puts "BIANCA: The player seems to be of sound mind."

        puts "#{player_name}: "
        contrastive_dialogue
      end

      current_sanity = sinon_int(current_sanity) do
        #puts "BIANCA: Remember to mind your sanity lest it slip."

        puts "#{player_name}: "
        npc_dialogue
      end
    end
  end
end

###################################################################################
#                                Get Statistics                                   #
###################################################################################
def cette(x, y)
  if x == ""
    puts "X is not provided."

    abort
  end
  
  if y == ""
    puts "X is not provided."

    abort
  end

  $that = x, y

  "Cette #{x} est #{y}."
end

def maisette(x, y)
  if x == ""
    puts "X is not provided."

    abort
  end
  
  if y == ""
    puts "Y is not provided."

    abort
  end
  
  $but_that = x, y

  "Mais cette #{x} est #{y}."
end

def sinon(a, b, c, d)
  if a == ""
    puts "A is not provided."

    abort
  end
  
  if b == ""
    puts "B is not provided."

    abort
  end

  if c == ""
    puts "C is not provided."

    abort
  end

  if d == ""
    puts "C is not provided."

    abort
  end
  
  $otherwise     = a, d
  $otherwise_not = a, b, c

  "Sinon #{a} c'est #{b} ou #{c} est aussi vrai. #{a} c'est #{d}."
end

def cette_int(condition)
  if condition
    yield
    
    return true
  end
  
  false
end

def maisette_int(already_done, condition)
  return true if already_done
  
  if condition
    yield
    
    return true
  end
end

def sinon_int(already_done)
  yield unless already_done
  
  unless already_done
    if defined?($otherwise)
      puts "#{$otherwise[0]} is 'THAT'"
      puts "#{$otherwise[1]} is 'WHAT'"
    end
  end
end

def necette_int(condition)
  if condition
    yield
    
    return true
  end
end

def nemaisette_int(not_already_done, condition)
  return true if not_already_done
  
  if condition
    yield
    
    return true
  end
end

def nesinon_int(not_already_done)
  yield unless not_already_done
  
  unless not_already_done
    if defined?($otherwise_not)
      puts "#{$otherwise_not[0]} is 'THAT'"
      puts "#{$otherwise_not[1]} is 'WHAT'"
    end
  end
end

## Japanese Contrastive
def sore(a, b)
  "Sora wa #{a} #{b}"
end

def shikashi(a, b)
  "Shikashi wa #{a} #{b}"
end

def matawa(a, b, c, d)
  "Matawa sora #{a} ni wa #{b} naishi #{c}, shikashi wa #{c}."
end

## Hanten-Ronri
def nisore(a, b)
  "Sono gyaku sora wa #{a} #{b}"
  
  $nisore = [ a, b ]
end

def nishikashi(a, b)
  "Sono gyaku shikashi wa #{a} #{b}."

  $nishikashi = [ a, b ]
end

def nimatawa(a, b, c, d)
  "Sono gyaku matawa sora #{a} wa #{b} naishi #{c}, shikashi wa #{d}"

  $urano_nest = [ b, c ]
  $urano_est  = d
end

## Japanese Contrastive Floats
def sore_float(condition)
  if condition
    yield
    
    return true
  end
  
  false
end

def shikashi_float(already_done, condition)
  return true if already_done
  
  if condition
    yield
    
    return true
  end
end

def matawa_float(already_done)
  yield unless already_done
  
  unless already_done
    #if defined?($otherwise)
      #puts "#{$otherwise_not[0]} is 'THAT'"
      #puts "#{$otherwise_not[1]} is 'WHAT'"
    #end
  end
end

## Hanten-Ronri
def nisore_float(condition)
  if condition
    yield
    
    return true
  end
  
  false
end

def nishikashi_float(not_already_done, condition)
  return true if not_already_done
  
  if condition
    yield
    
    return true
  end
end

def nimatawa_float(not_already_done)
  yield unless not_already_done
  
  unless not_already_done
    if defined?($otherwise_not)
      puts "#{$otherwise_not[0]} is 'THAT'"
      puts "#{$otherwise_not[1]} is 'WHAT'"
    end
  end
end

def sore_wa(a, b, c)
  2.times do
    get_statistics(:sore,     a,
                   :shikashi, b,
                   :matawa,   c)
                   
                   dynamic_mode_switcher
  end

  current_probability = sore_float($current_probability < 0.05) do
    puts "This is not presently probable."
  end

  current_probability = shikashi_float(current_probability, $current_probability < 0.85) do
    puts "There might be enough information to work with here: "

    thresholding($current_probability, 12, 12)
  end

  current_probability = matawa_float(current_probability) do
    puts "There is barely enough information, but I'll check: "

    thresholding($current_probability, 12, 12)
  end
end

def nisore_wa(a, b, c)
  2.times do
    get_statistics(:nisore,     a,
                   :nishikashi, b,
                   :nimatawa,   c)
                   
                   dynamic_mode_switcher
  end

  current_probability = sore_float($current_probability < 0.05) do
    puts "No information about the inverse of this assertion."
  end

  current_probability = shikashi_float(current_probability, $current_probability < 0.85) do
    puts "There might be enough to work with this negative information: "

    thresholding($current_probability, 12, 12)
  end

  current_probability = matawa_float(current_probability) do
    puts "There is barely enough negative information, but I'll check: "

    thresholding($current_probability, 12, 12)
  end
end

################################################################################################
#                                        File In / Out                                         #
################################################################################################
def self.ouvert(a, b, c, d, e, g)
  File.open(a, "a") { |f|
    f.puts b
  }

  File.open(c, "a") { |f|
    f.puts d
  }

  File.open(e, "a") { |f|
    f.puts g
  }
end
    
## Moves the old file to an isolated directory. A is the old file name, B is the new directory. C is equal to the old file name, D is the placehodler txt.
def self.wabisab(a, b, c)
  # wabisab("hello.txt", "hello", "hello.txt", "placeholder text")
        
  old_file = File.read(a)
      
  new_file = "#{old_file}"
      
  system("rm #{a}; mkdir #{b}")
      
  File.open("#{b}/#{a}", "w") { |f|
    f.puts new_file
  }
      
  File.open("#{c}", "w") { |f|
    f.puts d
  }
end

def ouvertsab(a, b, c, d, e, f, g, h, i)
  first_file  = File.read(a)
  second_file = File.read(d)
  third_file  = File.read(g)
  
  new_first  = "#{first_file}"
  new_second = "#{second_file}"
  new_third  = "#{third_file}"
  
  ouvert("#{b}/#{a}",  "#{new_first}",
         "#{e}/#{d}", "#{new_second}",
         "#{h}/#{g}",  "#{new_third}")
         
  ouvert("#{c}/#{a}",  "#{first_file}",
         "#{f}/#{d}", "#{second_file}",
         "#{i}/#{g}",  "#{third_file}")
         
         system("rm #{a}")
         system("rm #{d}")
         system("rm #{g}")
end

## Selective [ relocation of the cette conditional ]
def cetefwabisab(a, b, c) # cettef_wabisabi
  filename_ext = a
  filename     = b

  read_file = c
    
  d = wabisab("#{filename_ext}", "#{filename}", "#{filename}/old_#{c}")
end

#def analyze_cetefwabisab(a, b, c, d, e, f, g, h, i)
#  require "NeoPathfinding"
#  
#  filename_ext1 = a
#  filename1     = b
#  read_file1    = c
#  
#  filename_ext2 = d
#  filename2     = e
#  read_file2    = f
#
#  filename_ext3 = g
#  filename3     = h
#  read_file3    = i
#  
#  j = "#{filename_ext1}", "#{filename1}", "#{filename1}/old_#{c}"
#  k = "#{filename_ext2}", "#{filename2}", "#{filename2}/old_#{f}"
#  l = "#{filename_ext3}", "#{filename3}", "#{filename3}/old_#{i}"
#  
#  get_statistics(:first_transport,  "[#{j[0]} #{j[1]} #{j[1]}",
#                 :second_transport, "[#{k[0]} #{k[1]} #{k[1]}",
#                 :third_transport,  "[#{j[0]} #{j[1]} #{j[1]}")
#                 
#                 dynamic_reward_allocation
#end

def bleueceil_de_sukyana(a, b, c)
  user_followers = :followers, a
  user_following = :following, b
  
  bot_followers = user_followers / user_following
  bot_following = user_following / user_followers
  
  total_follower_bots  = bot_followers * 0.16
  total_following_bots = bot_following * 0.16
  
  puts "The amount of follower bots on bluesky: #{total_follower_bots}."
  puts "The amount of people followed who are bots: #{total_following_bots}."
end

module PlayerMechanics
  class OvertStatistics
    ###################################################################################
    #                           Self Contained AI Model                               #
    ###################################################################################
    def self.get_statistics(a1, a2, b1, b2, c1, c2)
      a = a1, a2
      b = b1, b2
      c = c1, c2

      matrix = [
        [[a[0], a[0]], [a[0], b[0]], [a[0], c[0]]],
        [[b[0], a[0]], [b[0], b[0]], [b[0], c[0]]],
        [[c[0], a[0]], [c[0], b[0]], [c[0], c[0]]],
      ], [
        [[a[1], a[1]], [a[1], b[1]], [a[1], c[1]]],
        [[b[1], a[1]], [b[1], b[1]], [b[1], c[1]]],
        [[c[1], a[1]], [c[1], b[1]], [c[1], c[1]]],
      ], [
        [[0.50, 0.50], [0.50, 0.50], [0.50, 0.50]],
        [[0.50, 0.50], [0.50, 0.50], [0.50, 0.50]],
        [[0.50, 0.50], [0.50, 0.50], [0.50, 0.50]],
      ]

      label_type       = matrix[0]
      definition_type  = matrix[1]
      probability_type = matrix[2]
  
      row_probability = 0.33
      col_probability = 0.33
  
      graph_selection = row_probability * col_probability

      row_options = [0, 1, 2]
      col_options = [0, 1, 2]
      arr_options = [0, 1]

      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      current_label       = label_type[cur_row][cur_col][cur_arr]
      current_definition  = definition_type[cur_row][cur_col][cur_arr]
      current_probability = probability_type[cur_row][cur_col][cur_arr] * graph_selection
  
      puts "I'm confident it is not [ #{current_label} #{current_definition} ] as it has only #{current_probability} probability."
  
      $current_probability = current_probability + current_probability
      $current_information = "#{current_label} #{current_definition}"
    end

    def self.gestate_l4(a1, a2, b1, b2, c1, c2, d1, d2)
      a = a1, a2
      b = b1, b2
      c = c1, c2
      d = d1, d2

      matrix = [
        [[a[0], a[0], a[0], a[0]],
         [a[0], a[0], a[0], b[0]],
         [a[0], a[0], a[0], c[0]],
         [a[0], a[0], a[0], d[0]]],

        [[b[0], b[0], b[0], a[0]],
         [b[0], b[0], b[0], b[0]],
         [b[0], b[0], b[0], c[0]],
         [b[0], b[0], b[0], d[0]]],

        [[c[0], c[0], c[0], a[0]],
         [c[0], c[0], c[0], b[0]],
         [c[0], c[0], c[0], c[0]],
         [c[0], c[0], c[0], d[0]]],

        [[d[0], d[0], d[0], a[0]],
         [d[0], d[0], d[0], b[0]],
         [d[0], d[0], d[0], c[0]],
         [d[0], d[0], d[0], d[0]]],
      ], [
        [[a[1], a[1], a[1], a[1]],
         [a[1], a[1], a[1], b[1]],
         [a[1], a[1], a[1], c[1]],
         [a[1], a[1], a[1], d[1]]],

        [[b[1], b[1], b[1], a[1]],
         [b[1], b[1], b[1], b[1]],
         [b[1], b[1], b[1], c[1]],
         [b[1], b[1], b[1], d[1]]],

        [[c[1], c[1], c[1], a[1]],
         [c[1], c[1], c[1], b[1]],
         [c[1], c[1], c[1], c[1]],
         [c[1], c[1], c[1], d[1]]],

        [[d[1], d[1], d[1], a[1]],
         [d[1], d[1], d[1], b[1]],
         [d[1], d[1], d[1], c[1]],
         [d[1], d[1], d[1], d[1]]],
      ], [
        [[0.25, 0.25, 0.25, 0.25],
         [0.25, 0.25, 0.25, 0.25],
         [0.25, 0.25, 0.25, 0.25],
         [0.25, 0.25, 0.25, 0.25]],

        [[0.25, 0.25, 0.25, 0.25],
         [0.25, 0.25, 0.25, 0.25],
         [0.25, 0.25, 0.25, 0.25],
         [0.25, 0.25, 0.25, 0.25]],

        [[0.25, 0.25, 0.25, 0.25],
         [0.25, 0.25, 0.25, 0.25],
         [0.25, 0.25, 0.25, 0.25],
         [0.25, 0.25, 0.25, 0.25]],

        [[0.25, 0.25, 0.25, 0.25],
         [0.25, 0.25, 0.25, 0.25],
         [0.25, 0.25, 0.25, 0.25],
         [0.25, 0.25, 0.25, 0.25]],
      ]

      label_type       = matrix[0]
      definition_type  = matrix[1]
      probability_type = matrix[2]
  
      row_probability = 0.25
      col_probability = 0.25
  
      graph_selection = row_probability * col_probability

      row_options = [0, 1, 2, 3]
      col_options = [0, 1, 2, 3]
      arr_options = [0, 1, 2, 3]

      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      current_label       = label_type[cur_row][cur_col][cur_arr]
      current_definition  = definition_type[cur_row][cur_col][cur_arr]
      current_probability = probability_type[cur_row][cur_col][cur_arr] * graph_selection
  
      puts "I'm confident it is not [ #{current_label} #{current_definition} ] as it has only #{current_probability} probability."
  
      $current_label       = current_label
      $current_probability = current_probability + current_probability
      $current_information = "#{current_label} #{current_definition}"
    end

    def self.reasses
      if $current_probability > 0.999999999999999999
        $current_probability = 0.9 / $current_probability
      end
  
      case $current_probability
      when 0.003921569000000000..0.287225000000000000
        puts "I'm confident it is not [ #{$current_information} ] because it has #{$current_probability}."
      when 0.287225000000000001..0.522225000000000000
        puts "I'm less unconfident it is not [ #{$current_information} ] because it has #{$current_probability}."
      when 0.522225000000000001..0.756112500000000000
        puts "I'm almost sure it is [ #{$current_information} ] because it has #{$current_probability}."
      when 0.756112500000000001..0.999999999999999999
        puts "I'm sure it is [ #{$current_information} ] because it has #{$current_probability}."

      else
        puts "The probability is either to low or to large, so I can't determine exactly."
      end
  
      $current_probability = $current_probability + $current_probability
    end

    def self.reconsider
      if $current_probability > 0.999999999999999999
        $current_probability = 0.9 / $current_probability
      end

      case $current_probability
      when 0.003921569000000000..0.287225000000000000
        puts "I'm confident it is not [ #{$current_information} ] because it has #{$current_probability}."
      when 0.287225000000000001..0.522225000000000000
        puts "I'm less unconfident it is not [ #{$current_information} ] because it has #{$current_probability}."
      when 0.522225000000000001..0.756112500000000000
        puts "I'm almost sure it is [ #{$current_information} ] because it has #{$current_probability}."
      when 0.756112500000000001..0.999999999999999999
        puts "I'm sure it is [ #{$current_information} ] because it has #{$current_probability}."
      else
        puts "The probability is either to low or to large, so I can't determine exactly."
      end
  
      old_probability      = $current_probability
      $current_probability = $current_probability / old_probability
    end

    def self.dynamic_reward_allocation
      l1_reasses = "level one reasses"
      l2_reasses = "level two reasses"
      l3_reasses = "level tre reasses"
      l4_reasses = "level fro reasses"

      reward_model = [
        [[l1_reasses, l1_reasses, l1_reasses, l1_reasses],
         [l1_reasses, l1_reasses, l1_reasses, l2_reasses],
         [l1_reasses, l1_reasses, l1_reasses, l3_reasses],
         [l1_reasses, l1_reasses, l1_reasses, l4_reasses]],
   
        [[l2_reasses, l2_reasses, l2_reasses, l1_reasses],
         [l2_reasses, l2_reasses, l2_reasses, l2_reasses],
         [l2_reasses, l2_reasses, l2_reasses, l3_reasses],
         [l2_reasses, l2_reasses, l2_reasses, l4_reasses]],
   
        [[l3_reasses, l3_reasses, l3_reasses, l1_reasses],
         [l3_reasses, l3_reasses, l3_reasses, l2_reasses],
         [l3_reasses, l3_reasses, l3_reasses, l3_reasses],
         [l3_reasses, l3_reasses, l3_reasses, l4_reasses]],
   
        [[l4_reasses, l4_reasses, l4_reasses, l1_reasses],
         [l4_reasses, l4_reasses, l4_reasses, l2_reasses],
         [l4_reasses, l4_reasses, l4_reasses, l3_reasses],
         [l4_reasses, l4_reasses, l4_reasses, l4_reasses]],
      ]

      row_options = [0, 1, 2, 3]
      col_options = [0, 1, 2, 3]
      arr_options = [0, 1, 2, 3]

      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample

      current_reward_structure = reward_model[cur_row][cur_col][cur_arr]

      if    current_reward_structure == l1_reasses; PlayerMechanics::OvertStatistics.reasses
      elsif current_reward_structure == l2_reasses; 2.times do PlayerMechanics::OvertStatistics.reasses end
      elsif current_reward_structure == l3_reasses; 3.times do PlayerMechanics::OvertStatistics.reasses end
      elsif current_reward_structure == l4_reasses; 4.times do PlayerMechanics::OvertStatistics.reasses end
      else
        PlayerMechanics::OvertStatistics.reasses
      end
    end

    def self.dynamic_guillotine_allocation
      l1_reasses = "level one reasses"
      l2_reasses = "level two reasses"
      l3_reasses = "level tre reasses"
      l4_reasses = "level fro reasses"

      reward_model = [
        [[l1_reasses, l1_reasses, l1_reasses, l1_reasses],
         [l1_reasses, l1_reasses, l1_reasses, l2_reasses],
         [l1_reasses, l1_reasses, l1_reasses, l3_reasses],
         [l1_reasses, l1_reasses, l1_reasses, l4_reasses]],
   
        [[l2_reasses, l2_reasses, l2_reasses, l1_reasses],
         [l2_reasses, l2_reasses, l2_reasses, l2_reasses],
         [l2_reasses, l2_reasses, l2_reasses, l3_reasses],
         [l2_reasses, l2_reasses, l2_reasses, l4_reasses]],
   
        [[l3_reasses, l3_reasses, l3_reasses, l1_reasses],
         [l3_reasses, l3_reasses, l3_reasses, l2_reasses],
         [l3_reasses, l3_reasses, l3_reasses, l3_reasses],
         [l3_reasses, l3_reasses, l3_reasses, l4_reasses]],
   
        [[l4_reasses, l4_reasses, l4_reasses, l1_reasses],
         [l4_reasses, l4_reasses, l4_reasses, l2_reasses],
         [l4_reasses, l4_reasses, l4_reasses, l3_reasses],
         [l4_reasses, l4_reasses, l4_reasses, l4_reasses]],
      ]

      row_options = [0, 1, 2, 3]
      col_options = [0, 1, 2, 3]
      arr_options = [0, 1, 2, 3]

      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample

      current_reward_structure = reward_model[cur_row][cur_col][cur_arr]

      if    current_reward_structure == l1_reasses; PlayerMechanics::OvertStatistics.reconsider
      elsif current_reward_structure == l2_reasses; 2.times do PlayerMechanics::OvertStatistics.reconsider end
      elsif current_reward_structure == l3_reasses; 3.times do PlayerMechanics::OvertStatistics.reconsider end
      elsif current_reward_structure == l4_reasses; 4.times do PlayerMechanics::OvertStatistics.reconsider end
      else
        PlayerMechanics::OvertStatistics.reconsider
      end
    end

    def self.get_edge_cases(a1, a2, b1, b2, c1, c2, d1, d2, e1, e2, f1, f2)
      a = [ a1, a2 ]
      b = [ b1, b2 ]
      c = [ c1, c2 ]
      d = [ d1, d2 ]
      e = [ e1, e2 ]
      f = [ f1, f2 ]

      edges_cases = [
        [ a[0], e[0], b[0], d[0], f[0], c[0] ],
        [ e[0], b[0], d[0], f[0], c[0], a[0] ],
        [ b[0], d[0], f[0], c[0], a[0], e[0] ],
        [ d[0], f[0], c[0], a[0], e[0], b[0] ],
        [ f[0], c[0], a[0], b[0], d[0], e[0] ],
        [ c[0], a[0], e[0], b[0], d[0], f[0] ],
      ], [
        [ a[1], e[1], b[1], d[1], f[1], c[1] ],
        [ e[1], b[1], d[1], f[1], c[1], a[1] ],
        [ b[1], d[1], f[1], c[1], a[1], e[1] ],
        [ d[1], f[1], c[1], a[1], e[1], b[1] ],
        [ f[1], c[1], a[1], b[1], d[1], e[1] ],
        [ c[1], a[1], e[1], b[1], d[1], f[1] ],
      ]
  
      symbols      = edges_cases[0]
      descriptions = edges_cases[1]

      row_options = [0, 1, 2, 3, 4, 5]
      col_options = [0, 1, 2, 3, 4, 5]
  
      cur_row = row_options.sample
      cur_col = col_options.sample
  
      first_symbol      = symbols[cur_row][cur_col] #[cur_arr]
      first_description = descriptions[cur_row][cur_col] #[cur_arr]

      cur_row = row_options.sample
      cur_col = col_options.sample
  
      second_symbol      = symbols[cur_row][cur_col] #[cur_arr]
      second_description = descriptions[cur_row][cur_col] #[cur_arr]

      cur_row = row_options.sample
      cur_col = col_options.sample
  
      third_symbol      = symbols[cur_row][cur_col] #[cur_arr]
      third_description = descriptions[cur_row][cur_col] #[cur_arr]
  
      2.times do
        get_statistics(first_symbol,  first_description,
                       second_symbol, second_description,
                       third_symbol,  third_description)

                       dynamic_mode_switcher
      end
  
      #thresholding($current_probability, 12, 12)
    end

    def self.dynamic_mode_switcher
      modes = [
        [["deposit", "deposit"], ["deposit", "extract"]],
        [["extract", "deposit"], ["extract", "extract"]],
      ]
  
      row_options = [0, 1]
      col_options = [0, 1]
      arr_options = [0, 1]

      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample 

      current_mode = modes[cur_row][cur_col][cur_arr]

      if    current_mode == "deposit"; dynamic_reward_allocation
      elsif current_mode == "extract"; dynamic_guillotine_allocation
      else
        dynamic_guillotine_allocation
      end
    end 

    def self.yumekusari(a, b, c, map_y, map_x)
      require "NeoPathfinding"

      markov_one = Gabbler.new
      markov_two = Gabbler.new
      markov_tre = Gabbler.new
  
      markov_one.learn(a)
      markov_two.learn(b)
      markov_tre.learn(c)
  
      d = markov_one.sentence
      e = markov_two.sentence
      f = markov_tre.sentence
  
      2.times do
        get_statistics(:markov_one, a,
                       :markov_two, b,
                       :markov_tre, c)
                 
                       dynamic_reward_allocation
                       thresholding($current_probability, map_y, map_x)
      end
    end
  end
  
  class SubliminalStatistics
  end
  
  class TernaryLogic
    ################################################################################################
    #                                     Beast Forecaster                                         #
    ################################################################################################
    def self.quantiffirm(p, q, probability)
      case probability
      when 0.00010..0.1250
        "#{p} therefore #{q} is false."
      when 0.1251..0.3625
        "#{p} therefore #{q} is largely false."
      when 0.3626..0.5125
        "#{p} therefore #{q} is partially true."
      when 0.5126..0.7563
        "#{p} therefore #{q} is largely true."
      when 0.7564..0.9999
        "#{p} therefore #{q} is true."
      else
        "#{p} therefore #{q} is not quantifiable."
      end
    end

    def self.risk_factor(risk)
      case risk
      when 0.750..1.000; print "Maximum Risk"; puts quantiffirm(": Such activities carry Maximum Risk", "this activity probably has Maximum risk", risk)
      when 0.500..0.749; print "High Risk";    puts quantiffirm(": Such activities carry High Risk", "this activity probably has High risk",    risk)
      when 0.250..0.499; print "Medium Risk";  puts quantiffirm(": Such activities carry Medium Risk", "this activity probably has Medium risk",  risk)
      when 0.125..0.249; print "Mild Risk";    puts quantiffirm(": Such activities carry Mild Risk", "this activity probably has Mild risk",    risk)
      when 0.010..0.124; print "Minimal Risk"; puts quantiffirm(": Such activities carry Minimal Risk", "this activity probably has Minimal risk", risk)
      else
        puts "The risk factor is unquantifiable."
      end
    end

    def self.thresholding(a, y, x)
      cognitive_threshold = 100
      probability         = a
      odds                = probability / ( 1 - probability )
      charted_assessment  = cognitive_threshold * probability
    
      size_of_map_y = y
      size_of_map_x = x
    
      map_cognitive_y = ( size_of_map_y * charted_assessment ) % size_of_map_y
      map_cognitive_x = ( size_of_map_x * charted_assessment ) % size_of_map_x

      puts "LEARNING ASSESSMENT"
      puts "The current map size is: #{x} by #{y}"
      puts "The current cognitive threshold is #{cognitive_threshold}"
      #puts "The current probability is #{probability}"
      puts "The current odds of learning this word is #{odds}"
      #puts "The current assessment of learning ability is #{charted_assessment}"
      puts "Therefore the approximate location of cognitive loading is the tile of #{map_cognitive_y.to_i} and #{map_cognitive_x.to_i}."
      puts quantiffirm("The cognitive threshold is #{cognitive_threshold}", "the approximate location of cognitive loading is the tile of #{map_cognitive_y} and #{map_cognitive_x}", probability)  
      puts " "
    end
  end

  class WorldState
    #########################################################################################################
    #                                      Maisette Sabots And Moss                                         #
    #########################################################################################################
    def self.mettre_de_sabots(a, b, c)
      "#{a} slips on special clogs to walk from #{b} to #{c}."
    end

    def self.porte_de_sabots(a, b, c)
      "#{a} walks in the clogs to walk from #{b} to #{c}."
  
      $shoe_durability = $shoe_durability - 1
    end

    def self.dommage_de_koke(a)
      # Damages a specified character with poison moss.
  
      $player_hp = $player_hp - 5
  
      "The #{a} currently has ##{$player_hp} life points left."
    end

    def self.poison_koke(a, b)
      # Spreads poison moss from specified distribution.
  
      "The poison moss spread from tile #{a} to tile #{b}."
  
      dommage_de_koke(your_name)
    end

    def self.est_empoisonne?(a)
      if $player_poison == true
        $player_hp = $player_hp - 5
      elsif $player_poison == true and $antidote >= 0
        $antiodate = $antidote - 1
    
        puts "#{a} has been cleared of poison."
      else
        puts "#{a} has not been poisoned."
      end
    end

    def self.avoir_un_bateau?(a)
      if    $player_boat == true and $water_acidic == false
        "#{a} has a boat, but is the water acidic?"
  
        est_eau_de_acide?(cthulhu_temple)
      elsif $player_boat == false and $water_acidic == true
        est_eau_de_acide?(cthulhu_temple)
    
        "You need to find a boat that can resist the PH value of dead restless spirits."
      elsif $player_boat == true and $water_acidic == true
        "#{a} has a boat that can be rowed across #{b}."
      else
        "#{a} has no boat doesn't know if water is acidic."
      end
    end

    def self.est_monstre_proche?(a, b, c)
      if $sea_gargoyal > 0
        "The sea gargoyals of #{a} are nearby."
    
        fight_snakes?(a)
      end
  
      if $acid_dragon > 0
        "The acid dragons of #{b} are nearby."
    
        fight_dragons?(b)
      end
  
      if $acid_serpent > 0
        "The acid snakes of #{c} are nearby."
    
        fight_serpents?(c)
      end
    end

    def self.est_porte_fermee?(a)
      if    $door_locked == true and $emergency_ax == false
        "Is the door locked? Yes, go find an emergency ax."
      elsif $door_locked == true and $emergency_ax == true
        "Is the door locked? You used the emergency ax."

        $emergency_ax = $emergency_ax - 1
      elsif $door_locked == false and $emergency_ax == false
        "Is the door locked? But its still advised to find an emergency ax."
      elsif $door_locked == false and $emergency_ax == true
        "Is the door locked? No, but save the ax for fighting monsters."
      else
      end
    end
  
    def self.parle_nous(a, b, c)
      h = :statement_one, a
      i = :statement_two, b
      j = :statement_tre, c
  
      statements = [
        [[h[0], h[0], h[0]], [h[0], h[0], i[0]], [h[0], h[0], j[0]]],
        [[i[0], i[0], h[0]], [i[0], i[0], i[0]], [i[0], i[0], j[0]]],
        [[j[0], j[0], h[0]], [j[0], j[0], i[0]], [j[0], j[0], j[0]]],
      ], [
        [[h[1], h[1], h[1]], [h[1], h[1], i[1]], [h[1], h[1], j[1]]],
        [[i[1], i[1], h[1]], [i[1], i[1], i[1]], [i[1], i[1], j[1]]],
        [[j[1], j[1], h[1]], [j[1], j[1], i[1]], [j[1], j[1], j[1]]],
      ]
  
      parle_symbol      = statements[0]
      parle_description = statements[1]
  
      row_options = [0, 1, 2]
      col_options = [0, 1, 2]
      arr_options = [0, 1, 2]
  
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      first_symbol      = parle_symbol[cur_row][cur_col][cur_arr]
      first_description = parle_description[cur_row][cur_col][cur_arr]

      row_options = [0, 1, 2]
      col_options = [0, 1, 2]
      arr_options = [0, 1, 2]
  
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      second_symbol      = parle_symbol[cur_row][cur_col][cur_arr]
      second_description = parle_description[cur_row][cur_col][cur_arr]

      row_options = [0, 1, 2]
      col_options = [0, 1, 2]
      arr_options = [0, 1, 2]
  
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      third_symbol      = parle_symbol[cur_row][cur_col][cur_arr]
      third_description = parle_description[cur_row][cur_col][cur_arr]

      2.times do
        PlayerMechanics::OvertStatistics.get_statistics(first_symbol, first_description,
                                                        second_symbol, second_description,
                                                        third_symbol, third_description)
   
        PlayerMechanics::OvertStatistics.dynamic_mode_switcher
      end
    end

    def self.lunar_predictions(a, b, c, d, e, f, g, h)
      new_moon        = :new_moon,        a
      waxing_crescent = :waxing_crescent, b
      first_quarter   = :first_quarter,   c
      waxing_gibbous  = :waxing_gibbous,  d
      full_moon       = :full_moon,       e
      waning_gibbous  = :waning_gibbous,  f
      last_quarter    = :last_quarter,    g
      waning_crescent = :waning_crescent, h
  
      lunar_phases = [
        [[ new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0],        new_moon[0] ],
         [ new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], waxing_crescent[0] ],
         [ new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0],   first_quarter[0] ],
         [ new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0],  waxing_gibbous[0] ],
         [ new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0],       full_moon[0] ],
         [ new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0],  waning_gibbous[0] ],
         [ new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0],    last_quarter[0] ],
         [ new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], waning_crescent[0] ]],
     
        [[ waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0],        new_moon[0] ],
         [ waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0] ],
         [ waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0],   first_quarter[0] ],
         [ waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0],  waxing_gibbous[0] ],
         [ waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0],       full_moon[0] ],
         [ waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0],  waning_gibbous[0] ],
         [ waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0],    last_quarter[0] ],
         [ waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waning_crescent[0] ]],

        [[ first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0],        new_moon[0] ],
         [ first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], waxing_crescent[0] ],
         [ first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0],   first_quarter[0] ],
         [ first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0],  waxing_gibbous[0] ],
         [ first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0],       full_moon[0] ],
         [ first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0],  waning_gibbous[0] ],
         [ first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0],    last_quarter[0] ],
         [ first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], waning_crescent[0] ]],

        [[ waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0],        new_moon[0] ],
         [ waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_crescent[0] ],
         [ waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0],   first_quarter[0] ],
         [ waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0],  waxing_gibbous[0] ],
         [ waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0],       full_moon[0] ],
         [ waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0],  waning_gibbous[0] ],
         [ waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0],    last_quarter[0] ],
         [ waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waning_crescent[0] ]],

        [[ full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0],        new_moon[0] ],
         [ full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], waxing_crescent[0] ],
         [ full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0],   first_quarter[0] ],
         [ full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0],  waxing_gibbous[0] ],
         [ full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0],       full_moon[0] ],
         [ full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0],  waning_gibbous[0] ],
         [ full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0],    last_quarter[0] ],
         [ full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], waning_crescent[0] ]],

        [[ waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0],        new_moon[0] ],
         [ waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waxing_crescent[0] ],
         [ waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0],   first_quarter[0] ],
         [ waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0],  waxing_gibbous[0] ],
         [ waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0],       full_moon[0] ],
         [ waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0],  waning_gibbous[0] ],
         [ waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0],    last_quarter[0] ],
         [ waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_crescent[0] ]],

        [[ last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0],        new_moon[0] ],
         [ last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], waxing_crescent[0] ],
         [ last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0],   first_quarter[0] ],
         [ last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0],  waxing_gibbous[0] ],
         [ last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0],       full_moon[0] ],
         [ last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0],  waning_gibbous[0] ],
         [ last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0],    last_quarter[0] ],
         [ last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], waning_crescent[0] ]],

        [[ waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0],        new_moon[0] ],
         [ waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waxing_crescent[0] ],
         [ waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0],   first_quarter[0] ],
         [ waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0],  waxing_gibbous[0] ],
         [ waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0],       full_moon[0] ],
         [ waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0],  waning_gibbous[0] ],
         [ waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0],    last_quarter[0] ],
         [ waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0] ]],
      ], [
        [[ new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1],        new_moon[1] ],
         [ new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], waxing_crescent[1] ],
         [ new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1],   first_quarter[1] ],
         [ new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1],  waxing_gibbous[1] ],
         [ new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1],       full_moon[1] ],
         [ new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1],  waning_gibbous[1] ],
         [ new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1],    last_quarter[1] ],
         [ new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], waning_crescent[1] ]],
     
        [[ waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1],        new_moon[1] ],
         [ waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1] ],
         [ waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1],   first_quarter[1] ],
         [ waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1],  waxing_gibbous[1] ],
         [ waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1],       full_moon[1] ],
         [ waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1],  waning_gibbous[1] ],
         [ waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1],    last_quarter[1] ],
         [ waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waning_crescent[1] ]],

        [[ first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1],        new_moon[1] ],
         [ first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], waxing_crescent[1] ],
         [ first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1],   first_quarter[1] ],
         [ first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1],  waxing_gibbous[1] ],
         [ first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1],       full_moon[1] ],
         [ first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1],  waning_gibbous[1] ],
         [ first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1],    last_quarter[1] ],
         [ first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], waning_crescent[1] ]],

        [[ waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1],        new_moon[1] ],
         [ waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_crescent[1] ],
         [ waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1],   first_quarter[1] ],
         [ waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1],  waxing_gibbous[1] ],
         [ waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1],       full_moon[1] ],
         [ waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1],  waning_gibbous[1] ],
         [ waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1],    last_quarter[1] ],
         [ waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waning_crescent[1] ]],

        [[ full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1],        new_moon[1] ],
         [ full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], waxing_crescent[1] ],
         [ full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1],   first_quarter[1] ],
         [ full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1],  waxing_gibbous[1] ],
         [ full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1],       full_moon[1] ],
         [ full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1],  waning_gibbous[1] ],
         [ full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1],    last_quarter[1] ],
         [ full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], waning_crescent[1] ]],

        [[ waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1],        new_moon[1] ],
         [ waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waxing_crescent[1] ],
         [ waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1],   first_quarter[1] ],
         [ waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1],  waxing_gibbous[1] ],
         [ waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1],       full_moon[1] ],
         [ waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1],  waning_gibbous[1] ],
         [ waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1],    last_quarter[1] ],
         [ waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_crescent[1] ]],

        [[ last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1],        new_moon[1] ],
         [ last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], waxing_crescent[1] ],
         [ last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1],   first_quarter[1] ],
         [ last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1],  waxing_gibbous[1] ],
         [ last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1],       full_moon[1] ],
         [ last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1],  waning_gibbous[1] ],
         [ last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1],    last_quarter[1] ],
         [ last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], waning_crescent[1] ]],

        [[ waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1],        new_moon[1] ],
         [ waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waxing_crescent[1] ],
         [ waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1],   first_quarter[1] ],
         [ waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1],  waxing_gibbous[1] ],
         [ waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1],       full_moon[1] ],
         [ waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1],  waning_gibbous[1] ],
         [ waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1],    last_quarter[1] ],
         [ waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1] ]],
      ]
  
      lunar_labels       = lunar_phases[0]
      lunar_descriptions = lunar_phases[1]
  
      row_options = [0, 1, 2, 3, 4, 5, 6, 7]
      col_options = [0, 1, 2, 3, 4, 5, 6, 7]
      arr_options = [0, 1, 2, 3, 4, 5, 6, 7]
  
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      first_lunar_label       = lunar_labels[cur_row][cur_col][cur_arr]
      first_lunar_description = lunar_descriptions[cur_row][cur_col][cur_arr]

      row_options = [0, 1, 2, 3, 4, 5, 6, 7]
      col_options = [0, 1, 2, 3, 4, 5, 6, 7]
      arr_options = [0, 1, 2, 3, 4, 5, 6, 7]
  
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      second_lunar_label       = lunar_labels[cur_row][cur_col][cur_arr]
      second_lunar_description = lunar_descriptions[cur_row][cur_col][cur_arr]
  
      row_options = [0, 1, 2, 3, 4, 5, 6, 7]
      col_options = [0, 1, 2, 3, 4, 5, 6, 7]
      arr_options = [0, 1, 2, 3, 4, 5, 6, 7]
  
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      third_lunar_label       = lunar_labels[cur_row][cur_col][cur_arr]
      third_lunar_description = lunar_descriptions[cur_row][cur_col][cur_arr]
  
      2.times do
        PlayerMechanics::OvertStatistics.get_statistics(first_lunar_label,  first_lunar_description,
                                                        second_lunar_label, second_lunar_description,
                                                        third_lunar_label,  third_lunar_description)
                   
        PlayerMechanics::OvertStatistics.dynamic_reward_allocation
      end
    end

    def self.lunair_de_oublie(a, b, c, d, e, f, g, h)
      new_moon        = :new_moon,        a
      waxing_crescent = :waxing_crescent, b
      first_quarter   = :first_quarter,   c
      waxing_gibbous  = :waxing_gibbous,  d
      full_moon       = :full_moon,       e
      waning_gibbous  = :waning_gibbous,  f
      last_quarter    = :last_quarter,    g
      waning_crescent = :waning_crescent, h
  
      lunar_phases = [
        [[ new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0],        new_moon[0] ],
         [ new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], waxing_crescent[0] ],
         [ new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0],   first_quarter[0] ],
         [ new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0],  waxing_gibbous[0] ],
         [ new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0],       full_moon[0] ],
         [ new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0],  waning_gibbous[0] ],
         [ new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0],    last_quarter[0] ],
         [ new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], waning_crescent[0] ]],
     
        [[ waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0],        new_moon[0] ],
         [ waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0] ],
         [ waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0],   first_quarter[0] ],
         [ waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0],  waxing_gibbous[0] ],
         [ waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0],       full_moon[0] ],
         [ waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0],  waning_gibbous[0] ],
         [ waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0],    last_quarter[0] ],
         [ waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waning_crescent[0] ]],

        [[ first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0],        new_moon[0] ],
         [ first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], waxing_crescent[0] ],
         [ first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0],   first_quarter[0] ],
         [ first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0],  waxing_gibbous[0] ],
         [ first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0],       full_moon[0] ],
         [ first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0],  waning_gibbous[0] ],
         [ first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0],    last_quarter[0] ],
         [ first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], waning_crescent[0] ]],

        [[ waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0],        new_moon[0] ],
         [ waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_crescent[0] ],
         [ waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0],   first_quarter[0] ],
         [ waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0],  waxing_gibbous[0] ],
         [ waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0],       full_moon[0] ],
         [ waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0],  waning_gibbous[0] ],
         [ waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0],    last_quarter[0] ],
         [ waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waning_crescent[0] ]],

        [[ full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0],        new_moon[0] ],
         [ full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], waxing_crescent[0] ],
         [ full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0],   first_quarter[0] ],
         [ full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0],  waxing_gibbous[0] ],
         [ full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0],       full_moon[0] ],
         [ full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0],  waning_gibbous[0] ],
         [ full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0],    last_quarter[0] ],
         [ full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], waning_crescent[0] ]],

        [[ waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0],        new_moon[0] ],
         [ waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waxing_crescent[0] ],
         [ waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0],   first_quarter[0] ],
         [ waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0],  waxing_gibbous[0] ],
         [ waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0],       full_moon[0] ],
         [ waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0],  waning_gibbous[0] ],
         [ waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0],    last_quarter[0] ],
         [ waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_crescent[0] ]],

        [[ last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0],        new_moon[0] ],
         [ last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], waxing_crescent[0] ],
         [ last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0],   first_quarter[0] ],
         [ last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0],  waxing_gibbous[0] ],
         [ last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0],       full_moon[0] ],
         [ last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0],  waning_gibbous[0] ],
         [ last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0],    last_quarter[0] ],
         [ last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], waning_crescent[0] ]],

        [[ waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0],        new_moon[0] ],
         [ waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waxing_crescent[0] ],
         [ waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0],   first_quarter[0] ],
         [ waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0],  waxing_gibbous[0] ],
         [ waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0],       full_moon[0] ],
         [ waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0],  waning_gibbous[0] ],
         [ waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0],    last_quarter[0] ],
         [ waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0] ]],
      ], [
        [[ new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1],        new_moon[1] ],
         [ new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], waxing_crescent[1] ],
         [ new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1],   first_quarter[1] ],
         [ new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1],  waxing_gibbous[1] ],
         [ new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1],       full_moon[1] ],
         [ new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1],  waning_gibbous[1] ],
         [ new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1],    last_quarter[1] ],
         [ new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], waning_crescent[1] ]],
     
        [[ waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1],        new_moon[1] ],
         [ waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1] ],
         [ waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1],   first_quarter[1] ],
         [ waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1],  waxing_gibbous[1] ],
         [ waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1],       full_moon[1] ],
         [ waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1],  waning_gibbous[1] ],
         [ waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1],    last_quarter[1] ],
         [ waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waning_crescent[1] ]],

        [[ first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1],        new_moon[1] ],
         [ first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], waxing_crescent[1] ],
         [ first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1],   first_quarter[1] ],
         [ first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1],  waxing_gibbous[1] ],
         [ first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1],       full_moon[1] ],
         [ first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1],  waning_gibbous[1] ],
         [ first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1],    last_quarter[1] ],
         [ first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], waning_crescent[1] ]],

        [[ waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1],        new_moon[1] ],
         [ waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_crescent[1] ],
         [ waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1],   first_quarter[1] ],
         [ waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1],  waxing_gibbous[1] ],
         [ waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1],       full_moon[1] ],
         [ waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1],  waning_gibbous[1] ],
         [ waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1],    last_quarter[1] ],
         [ waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waning_crescent[1] ]],

        [[ full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1],        new_moon[1] ],
         [ full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], waxing_crescent[1] ],
         [ full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1],   first_quarter[1] ],
         [ full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1],  waxing_gibbous[1] ],
         [ full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1],       full_moon[1] ],
         [ full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1],  waning_gibbous[1] ],
         [ full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1],    last_quarter[1] ],
         [ full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], waning_crescent[1] ]],

        [[ waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1],        new_moon[1] ],
         [ waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waxing_crescent[1] ],
         [ waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1],   first_quarter[1] ],
         [ waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1],  waxing_gibbous[1] ],
         [ waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1],       full_moon[1] ],
         [ waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1],  waning_gibbous[1] ],
         [ waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1],    last_quarter[1] ],
         [ waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_crescent[1] ]],

        [[ last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1],        new_moon[1] ],
         [ last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], waxing_crescent[1] ],
         [ last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1],   first_quarter[1] ],
         [ last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1],  waxing_gibbous[1] ],
         [ last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1],       full_moon[1] ],
         [ last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1],  waning_gibbous[1] ],
         [ last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1],    last_quarter[1] ],
         [ last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], waning_crescent[1] ]],

        [[ waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1],        new_moon[1] ],
         [ waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waxing_crescent[1] ],
         [ waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1],   first_quarter[1] ],
         [ waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1],  waxing_gibbous[1] ],
         [ waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1],       full_moon[1] ],
         [ waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1],  waning_gibbous[1] ],
         [ waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1],    last_quarter[1] ],
         [ waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1] ]],
      ]
  
      lunar_labels       = lunar_phases[0]
      lunar_descriptions = lunar_phases[1]
  
      row_options = [0, 1, 2, 3, 4, 5, 6, 7]
      col_options = [0, 1, 2, 3, 4, 5, 6, 7]
      arr_options = [0, 1, 2, 3, 4, 5, 6, 7]
  
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      first_lunar_label       = lunar_labels[cur_row][cur_col][cur_arr]
      first_lunar_description = lunar_descriptions[cur_row][cur_col][cur_arr]

      row_options = [0, 1, 2, 3, 4, 5, 6, 7]
      col_options = [0, 1, 2, 3, 4, 5, 6, 7]
      arr_options = [0, 1, 2, 3, 4, 5, 6, 7]
  
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      second_lunar_label       = lunar_labels[cur_row][cur_col][cur_arr]
      second_lunar_description = lunar_descriptions[cur_row][cur_col][cur_arr]
  
      row_options = [0, 1, 2, 3, 4, 5, 6, 7]
      col_options = [0, 1, 2, 3, 4, 5, 6, 7]
      arr_options = [0, 1, 2, 3, 4, 5, 6, 7]
  
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      third_lunar_label       = lunar_labels[cur_row][cur_col][cur_arr]
      third_lunar_description = lunar_descriptions[cur_row][cur_col][cur_arr]
  
      2.times do
        PlayerMechanics::OvertStatistics.get_statistics(first_lunar_label,   sabofensu(first_lunar_description),
                                                        second_lunar_label, sabofensu(second_lunar_description),
                                                        third_lunar_label,   sabofensu(third_lunar_description))
    
        PlayerMechanics::OvertStatistics.dynamic_reward_allocationdynamic_reward_allocation
      end
    end

    def self.lunair_impacts(a, b, c, d, e, f, g, h)
      new_moon        = :new_moon,        a
      waxing_crescent = :waxing_crescent, b
      first_quarter   = :first_quarter,   c
      waxing_gibbous  = :waxing_gibbous,  d
      full_moon       = :full_moon,       e
      waning_gibbous  = :waning_gibbous,  f
      last_quarter    = :last_quarter,    g
      waning_crescent = :waning_crescent, h
  
      lunar_phases = [
        [[ new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0],        new_moon[0] ],
         [ new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], waxing_crescent[0] ],
         [ new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0],   first_quarter[0] ],
         [ new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0],  waxing_gibbous[0] ],
         [ new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0],       full_moon[0] ],
         [ new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0],  waning_gibbous[0] ],
         [ new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0],    last_quarter[0] ],
         [ new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], new_moon[0], waning_crescent[0] ]],
     
        [[ waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0],        new_moon[0] ],
         [ waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0] ],
         [ waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0],   first_quarter[0] ],
         [ waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0],  waxing_gibbous[0] ],
         [ waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0],       full_moon[0] ],
         [ waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0],  waning_gibbous[0] ],
         [ waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0],    last_quarter[0] ],
         [ waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waxing_crescent[0], waning_crescent[0] ]],

        [[ first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0],        new_moon[0] ],
         [ first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], waxing_crescent[0] ],
         [ first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0],   first_quarter[0] ],
         [ first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0],  waxing_gibbous[0] ],
         [ first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0],       full_moon[0] ],
         [ first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0],  waning_gibbous[0] ],
         [ first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0],    last_quarter[0] ],
         [ first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], first_quarter[0], waning_crescent[0] ]],

        [[ waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0],        new_moon[0] ],
         [ waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_crescent[0] ],
         [ waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0],   first_quarter[0] ],
         [ waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0],  waxing_gibbous[0] ],
         [ waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0],       full_moon[0] ],
         [ waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0],  waning_gibbous[0] ],
         [ waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0],    last_quarter[0] ],
         [ waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waxing_gibbous[0], waning_crescent[0] ]],

        [[ full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0],        new_moon[0] ],
         [ full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], waxing_crescent[0] ],
         [ full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0],   first_quarter[0] ],
         [ full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0],  waxing_gibbous[0] ],
         [ full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0],       full_moon[0] ],
         [ full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0],  waning_gibbous[0] ],
         [ full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0],    last_quarter[0] ],
         [ full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], full_moon[0], waning_crescent[0] ]],

        [[ waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0],        new_moon[0] ],
         [ waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waxing_crescent[0] ],
         [ waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0],   first_quarter[0] ],
         [ waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0],  waxing_gibbous[0] ],
         [ waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0],       full_moon[0] ],
         [ waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0],  waning_gibbous[0] ],
         [ waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0],    last_quarter[0] ],
         [ waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_gibbous[0], waning_crescent[0] ]],

        [[ last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0],        new_moon[0] ],
         [ last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], waxing_crescent[0] ],
         [ last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0],   first_quarter[0] ],
         [ last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0],  waxing_gibbous[0] ],
         [ last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0],       full_moon[0] ],
         [ last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0],  waning_gibbous[0] ],
         [ last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0],    last_quarter[0] ],
         [ last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], last_quarter[0], waning_crescent[0] ]],

        [[ waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0],        new_moon[0] ],
         [ waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waxing_crescent[0] ],
         [ waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0],   first_quarter[0] ],
         [ waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0],  waxing_gibbous[0] ],
         [ waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0],       full_moon[0] ],
         [ waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0],  waning_gibbous[0] ],
         [ waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0],    last_quarter[0] ],
         [ waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0], waning_crescent[0] ]],
      ], [
        [[ new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1],        new_moon[1] ],
         [ new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], waxing_crescent[1] ],
         [ new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1],   first_quarter[1] ],
         [ new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1],  waxing_gibbous[1] ],
         [ new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1],       full_moon[1] ],
         [ new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1],  waning_gibbous[1] ],
         [ new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1],    last_quarter[1] ],
         [ new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], new_moon[1], waning_crescent[1] ]],
     
        [[ waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1],        new_moon[1] ],
         [ waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1] ],
         [ waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1],   first_quarter[1] ],
         [ waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1],  waxing_gibbous[1] ],
         [ waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1],       full_moon[1] ],
         [ waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1],  waning_gibbous[1] ],
         [ waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1],    last_quarter[1] ],
         [ waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waxing_crescent[1], waning_crescent[1] ]],

        [[ first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1],        new_moon[1] ],
         [ first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], waxing_crescent[1] ],
         [ first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1],   first_quarter[1] ],
         [ first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1],  waxing_gibbous[1] ],
         [ first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1],       full_moon[1] ],
         [ first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1],  waning_gibbous[1] ],
         [ first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1],    last_quarter[1] ],
         [ first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], first_quarter[1], waning_crescent[1] ]],

        [[ waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1],        new_moon[1] ],
         [ waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_crescent[1] ],
         [ waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1],   first_quarter[1] ],
         [ waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1],  waxing_gibbous[1] ],
         [ waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1],       full_moon[1] ],
         [ waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1],  waning_gibbous[1] ],
         [ waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1],    last_quarter[1] ],
         [ waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waxing_gibbous[1], waning_crescent[1] ]],

        [[ full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1],        new_moon[1] ],
         [ full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], waxing_crescent[1] ],
         [ full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1],   first_quarter[1] ],
         [ full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1],  waxing_gibbous[1] ],
         [ full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1],       full_moon[1] ],
         [ full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1],  waning_gibbous[1] ],
         [ full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1],    last_quarter[1] ],
         [ full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], full_moon[1], waning_crescent[1] ]],

        [[ waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1],        new_moon[1] ],
         [ waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waxing_crescent[1] ],
         [ waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1],   first_quarter[1] ],
         [ waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1],  waxing_gibbous[1] ],
         [ waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1],       full_moon[1] ],
         [ waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1],  waning_gibbous[1] ],
         [ waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1],    last_quarter[1] ],
         [ waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_gibbous[1], waning_crescent[1] ]],

        [[ last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1],        new_moon[1] ],
         [ last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], waxing_crescent[1] ],
         [ last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1],   first_quarter[1] ],
         [ last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1],  waxing_gibbous[1] ],
         [ last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1],       full_moon[1] ],
         [ last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1],  waning_gibbous[1] ],
         [ last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1],    last_quarter[1] ],
         [ last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], last_quarter[1], waning_crescent[1] ]],

        [[ waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1],        new_moon[1] ],
         [ waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waxing_crescent[1] ],
         [ waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1],   first_quarter[1] ],
         [ waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1],  waxing_gibbous[1] ],
         [ waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1],       full_moon[1] ],
         [ waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1],  waning_gibbous[1] ],
         [ waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1],    last_quarter[1] ],
         [ waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1], waning_crescent[1] ]],
      ]
  
      lunar_labels       = lunar_phases[0]
      lunar_descriptions = lunar_phases[1]
  
      row_options = [0, 1, 2, 3, 4, 5, 6, 7]
      col_options = [0, 1, 2, 3, 4, 5, 6, 7]
      arr_options = [0, 1, 2, 3, 4, 5, 6, 7]
  
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      first_lunar_label       = lunar_labels[cur_row][cur_col][cur_arr]
      first_lunar_description = lunar_descriptions[cur_row][cur_col][cur_arr]

      row_options = [0, 1, 2, 3, 4, 5, 6, 7]
      col_options = [0, 1, 2, 3, 4, 5, 6, 7]
      arr_options = [0, 1, 2, 3, 4, 5, 6, 7]
  
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      second_lunar_label       = lunar_labels[cur_row][cur_col][cur_arr]
      second_lunar_description = lunar_descriptions[cur_row][cur_col][cur_arr]
  
      row_options = [0, 1, 2, 3, 4, 5, 6, 7]
      col_options = [0, 1, 2, 3, 4, 5, 6, 7]
      arr_options = [0, 1, 2, 3, 4, 5, 6, 7]
  
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      third_lunar_label       = lunar_labels[cur_row][cur_col][cur_arr]
      third_lunar_description = lunar_descriptions[cur_row][cur_col][cur_arr]
  
      2.times do
        PlayerMechanics::OvertStatistics.get_statistics(first_lunar_label,   nesabofensu(first_lunar_description),
                                                        second_lunar_label, nesabofensu(second_lunar_description),
                                                        third_lunar_label,   nesabofensu(third_lunar_description))
                   
        PlayerMechanics::OvertStatistics.dynamic_reward_allocation
      end
    end

    def self.points_of_interest
      2.times do
        PlayerMechanics::OvertStatistics.get_statistics(:primary_hub,                 "The primary hub is an underground village or station.",
                                                        :secondary_hub,        "The second hub is where you can find new recruits or agents.",
                                                        :primary_enemies, "Your primary enemies come from areas furthest from supply chains.")

        PlayerMechanics::OvertStatistics.dynamic_reward_allocation
      end
    end

    def self.encounter_rate(a, b, c, d, e)
      sea_gargoyals  = :sea_gargoyal,   a
      acid_dragon    = :acid_dragon,    b
      acid_serpent   = :acid_serpent,   c
      traitorous_nun = :traitorous_nun, d
      cthulhu        = :cthulhu,        e
  
      monsters_encounters = [
        [[sea_gargoyals[0], sea_gargoyals[0], sea_gargoyals[0], sea_gargoyals[0],  sea_gargoyals[0]],
         [sea_gargoyals[0], sea_gargoyals[0], sea_gargoyals[0], sea_gargoyals[0],    acid_dragon[0]],
         [sea_gargoyals[0], sea_gargoyals[0], sea_gargoyals[0], sea_gargoyals[0],   acid_serpent[0]],
         [sea_gargoyals[0], sea_gargoyals[0], sea_gargoyals[0], sea_gargoyals[0], traitorous_nun[0]],
         [sea_gargoyals[0], sea_gargoyals[0], sea_gargoyals[0], sea_gargoyals[0],        cthulhu[0]]],
     
        [[acid_dragon[0], acid_dragon[0], acid_dragon[0], acid_dragon[0],  sea_gargoyals[0]],
         [acid_dragon[0], acid_dragon[0], acid_dragon[0], acid_dragon[0],    acid_dragon[0]],
         [acid_dragon[0], acid_dragon[0], acid_dragon[0], acid_dragon[0],   acid_serpent[0]],
         [acid_dragon[0], acid_dragon[0], acid_dragon[0], acid_dragon[0], traitorous_nun[0]],
         [acid_dragon[0], acid_dragon[0], acid_dragon[0], acid_dragon[0],        cthulhu[0]]],

        [[acid_serpent[0], acid_serpent[0], acid_serpent[0], acid_serpent[0],  sea_gargoyals[0]],
         [acid_serpent[0], acid_serpent[0], acid_serpent[0], acid_serpent[0],    acid_dragon[0]],
         [acid_serpent[0], acid_serpent[0], acid_serpent[0], acid_serpent[0],   acid_serpent[0]],
         [acid_serpent[0], acid_serpent[0], acid_serpent[0], acid_serpent[0], traitorous_nun[0]],
         [acid_serpent[0], acid_serpent[0], acid_serpent[0], acid_serpent[0],        cthulhu[0]]],

        [[traitorous_nun[0], traitorous_nun[0], traitorous_nun[0], traitorous_nun[0],  sea_gargoyals[0]],
         [traitorous_nun[0], traitorous_nun[0], traitorous_nun[0], traitorous_nun[0],    acid_dragon[0]],
         [traitorous_nun[0], traitorous_nun[0], traitorous_nun[0], traitorous_nun[0],   acid_serpent[0]],
         [traitorous_nun[0], traitorous_nun[0], traitorous_nun[0], traitorous_nun[0], traitorous_nun[0]],
         [traitorous_nun[0], traitorous_nun[0], traitorous_nun[0], traitorous_nun[0],        cthulhu[0]]],
     
        [[cthulhu[0], cthulhu[0], cthulhu[0], cthulhu[0],  sea_gargoyals[0]],
         [cthulhu[0], cthulhu[0], cthulhu[0], cthulhu[0],    acid_dragon[0]],
         [cthulhu[0], cthulhu[0], cthulhu[0], cthulhu[0],   acid_serpent[0]],
         [cthulhu[0], cthulhu[0], cthulhu[0], cthulhu[0], traitorous_nun[0]],
         [cthulhu[0], cthulhu[0], cthulhu[0], cthulhu[0],        cthulhu[0]]],
      ], [
        [[sea_gargoyals[1], sea_gargoyals[1], sea_gargoyals[1], sea_gargoyals[1],  sea_gargoyals[1]],
         [sea_gargoyals[1], sea_gargoyals[1], sea_gargoyals[1], sea_gargoyals[1],    acid_dragon[1]],
         [sea_gargoyals[1], sea_gargoyals[1], sea_gargoyals[1], sea_gargoyals[1],   acid_serpent[1]],
         [sea_gargoyals[1], sea_gargoyals[1], sea_gargoyals[1], sea_gargoyals[1], traitorous_nun[1]],
         [sea_gargoyals[1], sea_gargoyals[1], sea_gargoyals[1], sea_gargoyals[1],        cthulhu[1]]],
     
        [[acid_dragon[1], acid_dragon[1], acid_dragon[1], acid_dragon[1],  sea_gargoyals[1]],
         [acid_dragon[1], acid_dragon[1], acid_dragon[1], acid_dragon[1],    acid_dragon[1]],
         [acid_dragon[1], acid_dragon[1], acid_dragon[1], acid_dragon[1],   acid_serpent[1]],
         [acid_dragon[1], acid_dragon[1], acid_dragon[1], acid_dragon[1], traitorous_nun[1]],
         [acid_dragon[1], acid_dragon[1], acid_dragon[1], acid_dragon[1],        cthulhu[1]]],

        [[acid_serpent[1], acid_serpent[1], acid_serpent[1], acid_serpent[1],  sea_gargoyals[1]],
         [acid_serpent[1], acid_serpent[1], acid_serpent[1], acid_serpent[1],    acid_dragon[1]],
         [acid_serpent[1], acid_serpent[1], acid_serpent[1], acid_serpent[1],   acid_serpent[1]],
         [acid_serpent[1], acid_serpent[1], acid_serpent[1], acid_serpent[1], traitorous_nun[1]],
         [acid_serpent[1], acid_serpent[1], acid_serpent[1], acid_serpent[1],        cthulhu[1]]],

        [[traitorous_nun[1], traitorous_nun[1], traitorous_nun[1], traitorous_nun[1],  sea_gargoyals[1]],
         [traitorous_nun[1], traitorous_nun[1], traitorous_nun[1], traitorous_nun[1],    acid_dragon[1]],
         [traitorous_nun[1], traitorous_nun[1], traitorous_nun[1], traitorous_nun[1],   acid_serpent[1]],
         [traitorous_nun[1], traitorous_nun[1], traitorous_nun[1], traitorous_nun[1], traitorous_nun[1]],
         [traitorous_nun[1], traitorous_nun[1], traitorous_nun[1], traitorous_nun[1],        cthulhu[1]]],
     
        [[cthulhu[1], cthulhu[1], cthulhu[1], cthulhu[1],  sea_gargoyals[1]],
         [cthulhu[1], cthulhu[1], cthulhu[1], cthulhu[1],    acid_dragon[1]],
         [cthulhu[1], cthulhu[1], cthulhu[1], cthulhu[1],   acid_serpent[1]],
         [cthulhu[1], cthulhu[1], cthulhu[1], cthulhu[1], traitorous_nun[1]],
         [cthulhu[1], cthulhu[1], cthulhu[1], cthulhu[1],        cthulhu[1]]],
      ]
  
      monster_labels       = monsters_encounters[0]
      monster_descriptions = monsters_encounters[1]
  
      row_options = [0, 1, 2, 3, 4]
      col_options = [0, 1, 2, 3, 4]
      arr_options = [0, 1, 2, 3, 4]
  
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      first_monster_label       = monster_labels[cur_row][cur_col][cur_arr]
      first_monster_description = monster_descriptions[cur_row][cur_col][cur_arr]

      row_options = [0, 1, 2, 3, 4]
      col_options = [0, 1, 2, 3, 4]
      arr_options = [0, 1, 2, 3, 4]
  
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      second_monster_label       = monster_labels[cur_row][cur_col][cur_arr]
      second_monster_description = monster_descriptions[cur_row][cur_col][cur_arr]
  
      row_options = [0, 1, 2, 3, 4]
      col_options = [0, 1, 2, 3, 4]
      arr_options = [0, 1, 2, 3, 4]
  
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      third_monster_label       = monster_labels[cur_row][cur_col][cur_arr]
      third_monster_description = monster_descriptions[cur_row][cur_col][cur_arr]
  
      2.times do
        PlayerMechanics::OvertStatistics.get_statistics(first_monster_label,  first_monster_description,
                                                        second_monster_label, second_monster_description,
                                                        third_monster_label,  third_monster_description)
                   
        PlayerMechanics::OvertStatistics.dynamic_reward_allocation
      end
    end

    def self.loot_rate(a, b, c, d, e)
      poison_resistant_clogs  = :poison_resistant_clogs, a
      emergency_ax            = :emergency_ax,           b
      antidote                = :antidote,               c
      acid_resistant_boat     = :acid_resistant_boat,    d
      healing_salve           = :healing_salve,          e
  
      loot_encounters = [
        [[poison_resistant_clogs[0], poison_resistant_clogs[0], poison_resistant_clogs[0], poison_resistant_clogs[0],  poison_resistant_clogs[0]],
         [poison_resistant_clogs[0], poison_resistant_clogs[0], poison_resistant_clogs[0], poison_resistant_clogs[0],            emergency_ax[0]],
         [poison_resistant_clogs[0], poison_resistant_clogs[0], poison_resistant_clogs[0], poison_resistant_clogs[0],                antidote[0]],
         [poison_resistant_clogs[0], poison_resistant_clogs[0], poison_resistant_clogs[0], poison_resistant_clogs[0],     acid_resistant_boat[0]],
         [poison_resistant_clogs[0], poison_resistant_clogs[0], poison_resistant_clogs[0], poison_resistant_clogs[0],           healing_salve[0]]],

        [[emergency_ax[0], emergency_ax[0], emergency_ax[0], emergency_ax[0],  poison_resistant_clogs[0]],
         [emergency_ax[0], emergency_ax[0], emergency_ax[0], emergency_ax[0],            emergency_ax[0]],
         [emergency_ax[0], emergency_ax[0], emergency_ax[0], emergency_ax[0],                antidote[0]],
         [emergency_ax[0], emergency_ax[0], emergency_ax[0], emergency_ax[0],     acid_resistant_boat[0]],
         [emergency_ax[0], emergency_ax[0], emergency_ax[0], emergency_ax[0],           healing_salve[0]]],

        [[antidote[0], antidote[0], antidote[0], antidote[0],  poison_resistant_clogs[0]],
         [antidote[0], antidote[0], antidote[0], antidote[0],            emergency_ax[0]],
         [antidote[0], antidote[0], antidote[0], antidote[0],                antidote[0]],
         [antidote[0], antidote[0], antidote[0], antidote[0],     acid_resistant_boat[0]],
         [antidote[0], antidote[0], antidote[0], antidote[0],           healing_salve[0]]],

        [[acid_resistant_boat[0], acid_resistant_boat[0], acid_resistant_boat[0], acid_resistant_boat[0],  poison_resistant_clogs[0]],
         [acid_resistant_boat[0], acid_resistant_boat[0], acid_resistant_boat[0], acid_resistant_boat[0],            emergency_ax[0]],
         [acid_resistant_boat[0], acid_resistant_boat[0], acid_resistant_boat[0], acid_resistant_boat[0],                antidote[0]],
         [acid_resistant_boat[0], acid_resistant_boat[0], acid_resistant_boat[0], acid_resistant_boat[0],     acid_resistant_boat[0]],
         [acid_resistant_boat[0], acid_resistant_boat[0], acid_resistant_boat[0], acid_resistant_boat[0],           healing_salve[0]]],

        [[healing_salve[0], healing_salve[0], healing_salve[0], healing_salve[0],  poison_resistant_clogs[0]],
         [healing_salve[0], healing_salve[0], healing_salve[0], healing_salve[0],            emergency_ax[0]],
         [healing_salve[0], healing_salve[0], healing_salve[0], healing_salve[0],                antidote[0]],
         [healing_salve[0], healing_salve[0], healing_salve[0], healing_salve[0],     acid_resistant_boat[0]],
         [healing_salve[0], healing_salve[0], healing_salve[0], healing_salve[0],           healing_salve[0]]],
      ], [
        [[poison_resistant_clogs[1], poison_resistant_clogs[1], poison_resistant_clogs[1], poison_resistant_clogs[1],  poison_resistant_clogs[1]],
         [poison_resistant_clogs[1], poison_resistant_clogs[1], poison_resistant_clogs[1], poison_resistant_clogs[1],            emergency_ax[1]],
         [poison_resistant_clogs[1], poison_resistant_clogs[1], poison_resistant_clogs[1], poison_resistant_clogs[1],                antidote[1]],
         [poison_resistant_clogs[1], poison_resistant_clogs[1], poison_resistant_clogs[1], poison_resistant_clogs[1],     acid_resistant_boat[1]],
         [poison_resistant_clogs[1], poison_resistant_clogs[1], poison_resistant_clogs[1], poison_resistant_clogs[1],           healing_salve[1]]],

        [[emergency_ax[1], emergency_ax[1], emergency_ax[1], emergency_ax[1],  poison_resistant_clogs[1]],
         [emergency_ax[1], emergency_ax[1], emergency_ax[1], emergency_ax[1],            emergency_ax[1]],
         [emergency_ax[1], emergency_ax[1], emergency_ax[1], emergency_ax[1],                antidote[1]],
         [emergency_ax[1], emergency_ax[1], emergency_ax[1], emergency_ax[1],     acid_resistant_boat[1]],
         [emergency_ax[1], emergency_ax[1], emergency_ax[1], emergency_ax[1],           healing_salve[1]]],

        [[antidote[1], antidote[1], antidote[1], antidote[1],  poison_resistant_clogs[1]],
         [antidote[1], antidote[1], antidote[1], antidote[1],            emergency_ax[1]],
         [antidote[1], antidote[1], antidote[1], antidote[1],                antidote[1]],
         [antidote[1], antidote[1], antidote[1], antidote[1],     acid_resistant_boat[1]],
         [antidote[1], antidote[1], antidote[1], antidote[1],           healing_salve[1]]],

        [[acid_resistant_boat[1], acid_resistant_boat[1], acid_resistant_boat[1], acid_resistant_boat[1],  poison_resistant_clogs[1]],
         [acid_resistant_boat[1], acid_resistant_boat[1], acid_resistant_boat[1], acid_resistant_boat[1],            emergency_ax[1]],
         [acid_resistant_boat[1], acid_resistant_boat[1], acid_resistant_boat[1], acid_resistant_boat[1],                antidote[1]],
         [acid_resistant_boat[1], acid_resistant_boat[1], acid_resistant_boat[1], acid_resistant_boat[1],     acid_resistant_boat[1]],
         [acid_resistant_boat[1], acid_resistant_boat[1], acid_resistant_boat[1], acid_resistant_boat[1],           healing_salve[1]]],

        [[healing_salve[1], healing_salve[1], healing_salve[1], healing_salve[1],  poison_resistant_clogs[1]],
         [healing_salve[1], healing_salve[1], healing_salve[1], healing_salve[1],            emergency_ax[1]],
         [healing_salve[1], healing_salve[1], healing_salve[1], healing_salve[1],                antidote[1]],
         [healing_salve[1], healing_salve[1], healing_salve[1], healing_salve[1],     acid_resistant_boat[1]],
         [healing_salve[1], healing_salve[1], healing_salve[1], healing_salve[1],           healing_salve[1]]],
      ]
  
      loot_labels       = loot_encounters[0]
      loot_descriptions = loot_encounters[1]
  
      row_options = [0, 1, 2, 3, 4]
      col_options = [0, 1, 2, 3, 4]
      arr_options = [0, 1, 2, 3, 4]
  
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      first_loot_label       = loot_labels[cur_row][cur_col][cur_arr]
      first_loot_description = loot_descriptions[cur_row][cur_col][cur_arr]

      row_options = [0, 1, 2, 3, 4]
      col_options = [0, 1, 2, 3, 4]
      arr_options = [0, 1, 2, 3, 4]
  
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      second_loot_label       = loot_labels[cur_row][cur_col][cur_arr]
      second_loot_description = loot_descriptions[cur_row][cur_col][cur_arr]
  
      row_options = [0, 1, 2, 3, 4]
      col_options = [0, 1, 2, 3, 4]
      arr_options = [0, 1, 2, 3, 4]
  
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      third_loot_label       = loot_labels[cur_row][cur_col][cur_arr]
      third_loot_description = loot_descriptions[cur_row][cur_col][cur_arr]
  
      2.times do
        PlayerMechanics::OvertStatistics.get_statistics(first_loot_label,  first_loot_description,
                                                        second_loot_label, second_loot_description,
                                                        third_loot_label,  third_loot_description)

        PlayerMechanics::OvertStatistics.dynamic_reward_allocation
      end
    end

    def self.trap_rate(a, b, c, d, e)
      spiked_sea_raft  = :spiked_sea_raft, a # Spiked sea raft while visiting island.
      pressure_plates  = :pressure_plates, b # Pressure plates that behead characters.
      poison_moss      = :poison_moss,     c # Poison Moss
      poison_mines     = :poison_mines,    d # Mines that spray poison
      guillotine       = :guillotine,      e # Traitorous Nuns
  
      trap_encounters = [
        [[spiked_sea_raft[0], spiked_sea_raft[0], spiked_sea_raft[0], spiked_sea_raft[0],  spiked_sea_raft[0]],
         [spiked_sea_raft[0], spiked_sea_raft[0], spiked_sea_raft[0], spiked_sea_raft[0],  pressure_plates[0]],
         [spiked_sea_raft[0], spiked_sea_raft[0], spiked_sea_raft[0], spiked_sea_raft[0],      poison_moss[0]],
         [spiked_sea_raft[0], spiked_sea_raft[0], spiked_sea_raft[0], spiked_sea_raft[0],     poison_mines[0]],
         [spiked_sea_raft[0], spiked_sea_raft[0], spiked_sea_raft[0], spiked_sea_raft[0],       guillotine[0]]],

        [[pressure_plates[0], pressure_plates[0], pressure_plates[0], pressure_plates[0],  spiked_sea_raft[0]],
         [pressure_plates[0], pressure_plates[0], pressure_plates[0], pressure_plates[0],  pressure_plates[0]],
         [pressure_plates[0], pressure_plates[0], pressure_plates[0], pressure_plates[0],      poison_moss[0]],
         [pressure_plates[0], pressure_plates[0], pressure_plates[0], pressure_plates[0],     poison_mines[0]],
         [pressure_plates[0], pressure_plates[0], pressure_plates[0], pressure_plates[0],       guillotine[0]]],

        [[poison_moss[0], poison_moss[0], poison_moss[0], poison_moss[0],  spiked_sea_raft[0]],
         [poison_moss[0], poison_moss[0], poison_moss[0], poison_moss[0],  pressure_plates[0]],
         [poison_moss[0], poison_moss[0], poison_moss[0], poison_moss[0],      poison_moss[0]],
         [poison_moss[0], poison_moss[0], poison_moss[0], poison_moss[0],     poison_mines[0]],
         [poison_moss[0], poison_moss[0], poison_moss[0], poison_moss[0],       guillotine[0]]],

        [[poison_mines[0], poison_mines[0], poison_mines[0], poison_mines[0],  spiked_sea_raft[0]],
         [poison_mines[0], poison_mines[0], poison_mines[0], poison_mines[0],  pressure_plates[0]],
         [poison_mines[0], poison_mines[0], poison_mines[0], poison_mines[0],      poison_moss[0]],
         [poison_mines[0], poison_mines[0], poison_mines[0], poison_mines[0],     poison_mines[0]],
         [poison_mines[0], poison_mines[0], poison_mines[0], poison_mines[0],       guillotine[0]]],

        [[guillotine[0], guillotine[0], guillotine[0], guillotine[0],  spiked_sea_raft[0]],
         [guillotine[0], guillotine[0], guillotine[0], guillotine[0],  pressure_plates[0]],
         [guillotine[0], guillotine[0], guillotine[0], guillotine[0],      poison_moss[0]],
         [guillotine[0], guillotine[0], guillotine[0], guillotine[0],     poison_mines[0]],
         [guillotine[0], guillotine[0], guillotine[0], guillotine[0],       guillotine[0]]],
      ], [
        [[spiked_sea_raft[1], spiked_sea_raft[1], spiked_sea_raft[1], spiked_sea_raft[1],  spiked_sea_raft[1]],
         [spiked_sea_raft[1], spiked_sea_raft[1], spiked_sea_raft[1], spiked_sea_raft[1],  pressure_plates[1]],
         [spiked_sea_raft[1], spiked_sea_raft[1], spiked_sea_raft[1], spiked_sea_raft[1],      poison_moss[1]],
         [spiked_sea_raft[1], spiked_sea_raft[1], spiked_sea_raft[1], spiked_sea_raft[1],     poison_mines[1]],
         [spiked_sea_raft[1], spiked_sea_raft[1], spiked_sea_raft[1], spiked_sea_raft[1],       guillotine[1]]],

        [[pressure_plates[1], pressure_plates[1], pressure_plates[1], pressure_plates[1],  spiked_sea_raft[1]],
         [pressure_plates[1], pressure_plates[1], pressure_plates[1], pressure_plates[1],  pressure_plates[1]],
         [pressure_plates[1], pressure_plates[1], pressure_plates[1], pressure_plates[1],      poison_moss[1]],
         [pressure_plates[1], pressure_plates[1], pressure_plates[1], pressure_plates[1],     poison_mines[1]],
         [pressure_plates[1], pressure_plates[1], pressure_plates[1], pressure_plates[1],       guillotine[1]]],

        [[poison_moss[1], poison_moss[1], poison_moss[1], poison_moss[1],  spiked_sea_raft[1]],
         [poison_moss[1], poison_moss[1], poison_moss[1], poison_moss[1],  pressure_plates[1]],
         [poison_moss[1], poison_moss[1], poison_moss[1], poison_moss[1],      poison_moss[1]],
         [poison_moss[1], poison_moss[1], poison_moss[1], poison_moss[1],     poison_mines[1]],
         [poison_moss[1], poison_moss[1], poison_moss[1], poison_moss[1],       guillotine[1]]],

        [[poison_mines[1], poison_mines[1], poison_mines[1], poison_mines[1],  spiked_sea_raft[1]],
         [poison_mines[1], poison_mines[1], poison_mines[1], poison_mines[1],  pressure_plates[1]],
         [poison_mines[1], poison_mines[1], poison_mines[1], poison_mines[1],      poison_moss[1]],
         [poison_mines[1], poison_mines[1], poison_mines[1], poison_mines[1],     poison_mines[1]],
         [poison_mines[1], poison_mines[1], poison_mines[1], poison_mines[1],       guillotine[1]]],

        [[guillotine[1], guillotine[1], guillotine[1], guillotine[1],  spiked_sea_raft[1]],
         [guillotine[1], guillotine[1], guillotine[1], guillotine[1],  pressure_plates[1]],
         [guillotine[1], guillotine[1], guillotine[1], guillotine[1],      poison_moss[1]],
         [guillotine[1], guillotine[1], guillotine[1], guillotine[1],     poison_mines[1]],
         [guillotine[1], guillotine[1], guillotine[1], guillotine[1],       guillotine[1]]],
      ]
  
      trap_labels       = trap_encounters[0]
      trap_descriptions = trap_encounters[1]
  
      row_options = [0, 1, 2, 3, 4]
      col_options = [0, 1, 2, 3, 4]
      arr_options = [0, 1, 2, 3, 4]
  
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      first_trap_label       = trap_labels[cur_row][cur_col][cur_arr]
      first_trap_description = trap_descriptions[cur_row][cur_col][cur_arr]

      row_options = [0, 1, 2, 3, 4]
      col_options = [0, 1, 2, 3, 4]
      arr_options = [0, 1, 2, 3, 4]
  
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      second_trap_label       = trap_labels[cur_row][cur_col][cur_arr]
      second_trap_description = trap_descriptions[cur_row][cur_col][cur_arr]
  
      row_options = [0, 1, 2, 3, 4]
      col_options = [0, 1, 2, 3, 4]
      arr_options = [0, 1, 2, 3, 4]
  
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      third_trap_label       = trap_labels[cur_row][cur_col][cur_arr]
      third_trap_description = trap_descriptions[cur_row][cur_col][cur_arr]
  
      2.times do
        PlayerMechanics::OvertStatistics.get_statistics(first_trap_label,  first_trap_description,
                                                        second_trap_label, second_trap_description,
                                                        third_trap_label,  third_trap_description)
    
        PlayerMechanics::OvertStatistics.dynamic_reward_allocation
      end
    end

    def self.mutation_rate(a, b, c)
      mutation        = :mutation_deformity, a
      unhealing_wound = :unhealing_wound,    b
      sanity_loss     = :sanity_loss,        c
  
      status_effect = [
        [[mutation[0], mutation[0],        mutation[0]],
         [mutation[0], mutation[0], unhealing_wound[0]],
         [mutation[0], mutation[0],     sanity_loss[0]]],

        [[unhealing_wound[0], unhealing_wound[0],        mutation[0]],
         [unhealing_wound[0], unhealing_wound[0], unhealing_wound[0]],
         [unhealing_wound[0], unhealing_wound[0],     sanity_loss[0]]],

        [[sanity_loss[0], sanity_loss[0],        mutation[0]],
         [sanity_loss[0], sanity_loss[0], unhealing_wound[0]],
         [sanity_loss[0], sanity_loss[0],     sanity_loss[0]]],
      ], [
        [[mutation[1], mutation[1],        mutation[1]],
         [mutation[1], mutation[1], unhealing_wound[1]],
         [mutation[1], mutation[1],     sanity_loss[1]]],

        [[unhealing_wound[1], unhealing_wound[1],        mutation[1]],
         [unhealing_wound[1], unhealing_wound[1], unhealing_wound[1]],
         [unhealing_wound[1], unhealing_wound[1],     sanity_loss[1]]],

        [[sanity_loss[1], sanity_loss[1],        mutation[1]],
         [sanity_loss[1], sanity_loss[1], unhealing_wound[1]],
         [sanity_loss[1], sanity_loss[1],     sanity_loss[1]]],
      ]
  
      effect_labels       = status_effect[0]
      effect_descriptions = status_effect[1]
  
      row_options = [0, 1, 2]
      col_options = [0, 1, 2]
      arr_options = [0, 1, 2]
  
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      first_effect_label       = effect_labels[cur_row][cur_col][cur_arr]
      first_effect_description = effect_descriptions[cur_row][cur_col][cur_arr]

      row_options = [0, 1, 2]
      col_options = [0, 1, 2]
      arr_options = [0, 1, 2]
  
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      second_effect_label       = effect_labels[cur_row][cur_col][cur_arr]
      second_effect_description = effect_descriptions[cur_row][cur_col][cur_arr]
  
      row_options = [0, 1, 2]
      col_options = [0, 1, 2]
      arr_options = [0, 1, 2]
  
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      third_effect_label       = effect_labels[cur_row][cur_col][cur_arr]
      third_effect_description = effect_descriptions[cur_row][cur_col][cur_arr]

      2.times do
        PlayerMechanics::OvertStatistics.get_statistics(first_effect_label,   first_effect_description,
                                                        second_effect_label, second_effect_description,
                                                        third_effect_label,   third_effect_description)
                   
        PlayerMechanics::OvertStatistics.dynamic_reward_allocation
      end
    end
  end
  
  class PlayerTrackers
    #########################################################################################################
    #                                          Player Trackers                                              #
    #########################################################################################################
    def self.contrast_player
      player_hp = $player_hp

      ## Analyze current player life points.
      compared_p_count = cette_int(player_hp <= 2) do
        print "You are in critical condition. Translation: "; puts cette("joueuse", "sante critique")
    
        puts "Object: #{$that[0]}"
        puts "Status: #{$that[1]}"
      end

      compared_p_count = maisette_int(compared_p_count, player_hp >= 8) do
        print "You are in very good condition. Translation: "; puts maisette('joueuse', 'tres bien')
    
        puts "Object: #{$but_that[0]}"
        puts "Status: #{$but_that[1]}"
      end

      compared_p_count = sinon_int(compared_p_count) do
        print "Be mindful of your current hit points, as its at: #{player_hp}. Translation: "; puts sinon('joueuse', 'sante critique', 'tres bien', 'conscient')

        puts "N'est: #{$otherwise[0]}, #{$otherwise[1]} Mais: #{$otherwise[2]}"
      end
    end
  end

  class CognitiveArchitecture
    #########################################################################################################
    #                                     Maisette Gameplay Analyses                                        #
    #########################################################################################################
    # Input sound quality, scent, and movement patterns in OSV order.
    def self.analyze_luring(a, b, c)
      puts "LURING"
  
      2.times do
        get_statistics(:sound,    a,
                       :scent,    b,
                       :movement, c)
                 
                       dynamic_reward_allocation
                       dynamic_reward_allocation

                       #sum_of_probabilities
      end
    end

    # Input kinetic motion, electrical charge, and chemical properties in OSV order.
    def self.analyze_stunning(a, b, c)
      puts "STUNNING"
  
      2.times do
        get_statistics(:kinetic_motion,      a,
                       :electrical_charge,   b,
                       :chemical_properties, c)
                 
                       dynamic_reward_allocation
                       dynamic_reward_allocation

                       #sum_of_probabilities
      end
    end

    # Input line of sight, pressure points, and noise locations in OSV order.
    def self.analyze_trapping(a, b, c)
      puts "TRAPPING"
  
      2.times do
        get_statistics(:line_of_sight,   a,
                       :pressure_points, b,
                       :noise_location,  c)
                 
                       dynamic_reward_allocation
                       dynamic_reward_allocation

                       #sum_of_probabilities
      end
    end

    ################################################################################################
    #                                        Player Guide                                          #
    ################################################################################################
    # This guides the player in the direction you want to go, rather than explicitely writing      #
    # story branches                                                                               #
    ################################################################################################
    def self.guide_player(a, b, c)
      2.times do
        get_statistics(:branch_1, a,
                       :branch_2, b,
                       :branch_3, c)
                 
                       dynamic_reward_allocation
      end

      inferred_result = cette_int($current_probability < 0.0005) do
        cette("point de difference", "non")
    
        that = $that[0]
        what = $that[1]
      end

      inferred_result = maisette_int(inferred_result, $current_probability < 0.8) do
        maisette("point de difference", "oui")

        but_that = $but_that[0]
        but_what = $but_what[1]
      end

      inferred_result = sinon_int(inferred_result) do
        sinon("point de difference", "peut etre")
    
        otherwise_that     = $otherwise[0]
        otherwise_what     = $otherwise[3]
  
        d = $otherwise_not[1]
        e = $otherwise_not[2]
  
        otherwise_not_what = [
          [[d, d], [d, e]],
          [[e, d], [e, e]],
        ]
  
        row_options = [0, 1]
        col_options = [0, 1]
        arr_options = [0, 1]
  
        cur_row = row_options.sample
        cur_col = col_options.sample
        cur_arr = arr_options.sample
  
        non_cette = otherwise_not_what[cur_row][cur_col][cur_arr]
  
        puts "Cette n'est #{non_cette}."
      end
    end
  end
  
  class EnteriorHandling

    # Tar and feather the distributor of propaganda.
    def self.taruchienne(a, b)
      "Le ancor de propaganda #{a} est anos taros avec #{b}."
    end

    def self.etudie_taruchienne(a, b, c)
      require "NeoPathfinding"
  
      2.times do
        get_statistics(:etudie_taruchienne_une,   a,
                       :etudie_taruchienne_deux,  b,
                       :etudie_taruchienne_trois, c)
  
        dynamic_reward_allocation
      end
    end

    # Evaluate the branding of objects. Ex. Label of cigarette packs.
    def self.evaluer_burandingu(a, b, c)
      "Le image du marque en #{a} es #{b}, mais devrait #{c}."
    end

    # Study the branding of objects in bulk
    def self.etudie_burandingu_trois(a, b, c, d, e, f)
      require "NeoPathfinding"
  
      2.times do
        get_statistics(:etudie_burandingu_une,   a,
                       :etudie_burandingu_deux,  b,
                       :etudie_burandingu_trois, c)
  
        dynamic_reward_allocation
      end
    end

    # Evaluate the bootleg signal from the foreign network
    def self.butajambe_rsignal(a, b)
      "#{a} sortie le rsignal pour #{b} a regarde le ecran plat."
    end

    # Evaluate the bootleg signal from the foreign network in bulk
    def self.etudie_butajambe_trois(a, b, c, d, e, f)
      require "NeoPathfinding"
  
      2.times do
        get_statistics(:etudie_butajambe_une,   a,
                       :etudie_butajambe_deux,  b,
                       :etudie_butajambe_trois, c)
  
        dynamic_reward_allocation
      end
    end
    
    def suitchi_une(your_name, her_name)
      butajambe_rsignal(your_name, her_name)
    end
  
    def suitchi_deux(your_name, her_name)
      butajambe_rsignal(your_name, her_name)
    end
  
    def suitchi_trois(your_name, her_name)
      butajambe_rsignal(your_name, her_name)
    end
  
    # Flip the switches in the bedroom
    def sortie
      puts "\nDocumenting jamped signal..."
      PlayerMechanics::DoorwayHandling.suitchi_une("Your Name", "Her Name")
      
      puts "\nDocumenting jamped signal..."
      PlayerMechanics::DoorwayHandling.suitchi_deux("Your Name", "Her Name")
      
      puts "\nDocumenting jamped signal..."
      PlayerMechanics::DoorwayHandling.suitchi_trois("Your Name", "Her Name")
    end
    
    # Watch the television
    def etudie_ecranplat(a, b)
      puts "Vous regarde le canel de #{a}, avec le autre personne #{b}."
  
      a = "Sortie Une"
      b = "Sortie Deux"
      c = "Sortie Trois"
  
      switches = [
        [[a, a, a],
         [a, a, b],
         [a, a, c]],
     
        [[b, b, a],
         [b, b, b],
         [b, b, c]],

        [[c, c, a],
         [c, c, b],
         [c, c, c]],
      ]
  
      row_options = [0, 1, 2]
      col_options = [0, 1, 2]
      arr_options = [0, 1, 2]
  
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      current_etudie = switches[cur_row][cur_col][cur_arr]
  
      if    a == current_etudie; sortie.suitchi_une
      elsif b == current_etudio; sortie.suitchi_deux
      elsif c == current_etudio; sortie.suitchi_trois
      else
        sortie.suitchi_une
      end
    end
  end
  
  class Commands
    def self.lure
      puts "The player lures #{monster_name} in their general direction."
  
      sleep(1.5)
    end

    def self.stun
      puts "The player temporarily stuns #{monster_name}. ...#{monster_name} resumes moving."
  
      $enemy_hp = $enemy_hp - 1
  
      sleep(1.5)
    end

    def self.trap
      puts "You managed to trap #{monster_name}..."
  
      puts "You promptly release it and tend to its wounds."
  
      abort
    end

    def self.scan
      #require "NeoPathfinding"
  
      2.times do
        get_statistics(:lure, "This allows you to scan #{monster_name} stats.",
                       :stun, "This allows you to stun #{monster_name} temporarily.",
                       :trap, "This allows you to trap #{monster_name} to remove them from field.")
   
                       dynamic_reward_allocation
                       #thresholding($current_probability, 12, 12)
          
                       #$choice = $current_label
      end
  
      gets.chomp
    end
  
    def self.flaner(a, b)
      "Vous flaner pour #{a} a #{b}."
    end
    
    def self.buisaut(a, b)
      "Vous buisaut de #{a} a #{b}."
    end
    
    ## To hold onto a rock ledge.
    def self.entreintiwadano(a, b)
      "Vous entraintiwadano de #{a} a #{b}."
    end
    
    ## Break into a portion of the estate of the Atana's at a specific location.
    def self.entreintatana(a, b)
      "Vous entraint de #{a} a #{b}."
    end
    
    ## Transfer blood from monster to maid.
    def self.morsurenekku(a, b)
      "Vous manger ana nekku #{a}, souhaitez-vous transferer a #{b}?"
    end
    
    ## Merci kill a specific dying monster.
    def self.coup_de_grace(a)
      "Vous coupe un coupe de grace sur #{a}."
    end
    
    ## Disarm trap at desired location.
    def self.busokaijoplege(a, b)
      "Vous busokaiplege un plege #{a} #{b}."
    end
    
    ## Exit current menu and switch to desired menu.
    def self.viola(a, b)
      "Viola cette menu #{a}, ouvert #{b}."
    end
    
    ## Play example scenes ahead of time to know what wrong paths are without risking MC's life.
    def self.appel_du_vide
      "En cette vide, vous mort en #{a}, par #{b}."
    end

    # Double stillbirth, but can also mean twins that died at a young age.
    def self.doubleshizan(a, b)
      "Le bebes #{a} et #{b} sont en mort pour quelque temps."
    end

    def self.double_stillbirth(a, b)
      "The baby #{a} and #{b} are dead for some time."
    end

    # Attend podcast about twins
    def self.podcast_de_tsuin(a, b)
      "Vous sont en un podcast avec le nom 'podcast de tsuin' en memorie de #{a} and #{b}."
    end

    def self.attend_podcast(a, b)
      "You are in a podcast with the name 'podcast de tsuin' in memory of #{a} and #{b}."
    end

    # Leave podcast
    def self.partircosse(a, b)
      "Vous appuyez le record pour le sortie pour #{a} and #{b}."
    end

    # Purchase at baby robot at a specific location
    def self.bebelerobo(a, b, c)
      "Vous achetant un bebe robo #{a} en le supe en le coords #{a} and #{b}." # This possibly refers to a television.
    end

    def self.purchase_baby_robot(a, b, c)
      "You purchase a baby robot #{a} in the coodinates of #{a} and #{b}."
    end

    # Plant a robot at a specific location
    def self.roboplat(a, b, c)
      "Le roboe #{a} est plat en le jardin de #{b} and #{c}."
    end

    def self.flatten_robot(a, b, c)
      "The robot #{a} is planted in the garden of #{b} and #{c}."
    end

    # Plant a tree of for haunted houses.
    def self.abrependre(a, b, c)
      "Le abre en le plat es: [ #{a}, #{b}, #{c} ]"
    end

    def self.plant_tree(a, b, c)
      "The tree in the plate is: [ #{a}, #{b}, #{c} ]"
    end
  end
  
  class PlayerAnalyzeEnemy
    ## Experimental feature based on Grandia's ability to scan enemy metric, with the distinction being a blend of naive bayes and decision trees.
    def self.ennemi_sukyan(a, b, c, d, e)
      require "SelfModifiedDecisionTree"
  
      monster_metrics = RevisedBayes.new(:low_sp,     :some_sp,   :medium_sp,   :high_sp,   :max_sp),
                        RevisedBayes.new(:low_hp,     :some_hp,   :medium_hp,   :high_hp,   :max_hp),
                        RevisedBayes.new(:low_atk,   :some_atk,  :medium_atk,  :high_atk,  :max_atk),
                        RevisedBayes.new(:low_heal, :some_heal, :medium_heal, :high_heal, :max_heal),
                        RevisedBayes.new(:new_moon,
                                         :waxing_crescent,
                                         :first_quarter,
                                         :waxing_gibbous,
                                         :full_moon,
                                         :waning_gibbous,
                                         :last_quarter,
                                         :waning_crescent),
 
      sanity_status = monster_metrics[0]
      hp_status     = monster_metrics[1]
      atk_status    = monster_metrics[2]
      heal_status   = monster_metrics[3]
      lunar_phase   = monster_metrics[4]
  
      ## Sanity Status
      sanity_status.train(:low_sp,      "The monster has 0 sanity points.",    "low sp")
      sanity_status.train(:some_sp,     "The monster has 4 sanity points.",    "low sp")
      sanity_status.train(:medium_sp,   "The monster has 7 sanity points.", "medium sp")
      sanity_status.train(:high_sp,     "The monster has 9 sanity points.",   "high sp")
      sanity_status.train(:max_sp,     "The monster has 10 sanity points.",    "max sp")
  
      sanity_classification = sanity_status.classify(a)
  
      ## HP Status
      hp_status.train(:low_hp,      "The monster has 0 health points.",    "low hp")
      hp_status.train(:some_hp,     "The monster has 4 health points.",    "low hp")
      hp_status.train(:medium_hp,   "The monster has 7 health points.", "medium hp")
      hp_status.train(:high_hp,     "The monster has 9 health points.",   "high hp")
      hp_status.train(:max_hp,     "The monster has 10 health points.",    "max hp")
  
      hp_classification = hp_status.classify(b)
  
      ## ATK Status
      atk_status.train(:low_atk,     "The monster has 0 attack power.",    "low atk")
      atk_status.train(:some_atk,    "The monster has 4 attack power.",    "low atk")
      atk_status.train(:medium_atk,  "The monster has 7 attack power.", "medium atk")
      atk_status.train(:high_atk,    "The monster has 9 attack power.",   "high atk")
      atk_status.train(:max_atk,    "The monster has 10 attack power.",    "max atk")

      atk_classification = atk_status.classify(c)
  
      ## Heal Status
      heal_status.train(:low_heal,     "The monster has 0 attack power.",    "low heal")
      heal_status.train(:some_heal,    "The monster has 4 attack power.",    "low heal")
      heal_status.train(:medium_heal,  "The monster has 7 attack power.", "medium heal")
      heal_status.train(:high_heal,    "The monster has 9 attack power.",   "high heal")
      heal_status.train(:max_heal,    "The monster has 10 attack power.",    "max heal")
 
      heal_classification = heal_status.classify(d)
  
      ## Lunar Phrase
      lunar_phase.train(:new_moon,               "La phase lunaire actuelle est: New Moon. Réinitialisation des statistiques du joueur...",        "new moon")
      lunar_phase.train(:waxing_crescent,  "La phase lunaire actuelle est: Waxing Gibbous. Réinitialisation des statistiques du joueur...", "waxing crescent")
      lunar_phase.train(:first_quarter,     "La phase lunaire actuelle est: First Quarter. Réinitialisation des statistiques du joueur...",   "first quarter")
      lunar_phase.train(:waxing_gibbous,   "La phase lunaire actuelle est: Waxing Gibbous. Réinitialisation des statistiques du joueur...",  "waxing gibbous")
      lunar_phase.train(:full_moon,             "La phase lunaire actuelle est: Full Moon. Réinitialisation des statistiques du joueur...",       "full moon")
      lunar_phase.train(:waning_gibbous,   "La phase lunaire actuelle est: Waning Gibbous. Réinitialisation des statistiques du joueur...",  "waning gibbous")
      lunar_phase.train(:last_quarter,       "La phase lunaire actuelle est: Last Quarter. Réinitialisation des statistiques du joueur...",    "last quarter")
      lunar_phase.train(:waning_crescent, "La phase lunaire actuelle est: Waning Crescent. Réinitialisation des statistiques du joueur...", "waning crescent")
  
      lunar_classification = lunar_phrase.classify(e)
  
      ### Decisions from tree
      attributes = ["Sanity"], ["Life Points"], ["Attack Power"], ["Healing Rate"], ["Lunar Phase"]
  
      training = [
        [0.125,     "Low Sanity"],
        [0.3435,   "Some Sanity"],
        [0.562,  "Medium Sanity"],
        [0.7805,   "High Sanity"],
        [0.999,    "Full Sanity"],
      ], [
        [0.125,     "Low HP"],
        [0.3435,   "Some HP"],
        [0.562,  "Medium HP"],
        [0.7805,   "High HP"],
        [0.999,    "Full HP"],
      ], [
        [0.125,     "Low Attack Power"],
        [0.3435,   "Some Attack Power"],
        [0.562,  "Medium Attack Power"],
        [0.7805,   "High Attack Power"],
        [0.999,    "Full Attack Power"],
      ], [
        [0.125,     "Low Healing Rate"],
        [0.3435,   "Some Healing Rate"],
        [0.562,  "Medium Healing Rate"],
        [0.7805,   "High Healing Rate"],
        [0.999,    "Full Healing Rate"],
      ], [
        [0.125,            "New Moon"],
        [0.2146875, "Waxing Crescent"],
        [0.304375,    "First quarter"],
        [0.39025,    "Waxing Gibbous"],
        [0.647875,        "Full Moon"],
        [0.82725,    "Waning Gibbous"],
        [0.913125,     "Last Quarter"],
        [0.999,     "Waning Crescent"],
      ]

      dec_tree_configurations = DecisionTree::ID3Tree.new(attributes[0], training[0], 1, :continuous),
                                DecisionTree::ID3Tree.new(attributes[1], training[1], 1, :continuous),
                                DecisionTree::ID3Tree.new(attributes[2], training[2], 1, :continuous),
                                DecisionTree::ID3Tree.new(attributes[3], training[3], 1, :continuous),
                                DecisionTree::ID3Tree.new(attributes[4], training[4], 1, :continuous),
            
      current_dectree1 = dec_tree_configurations[0]
      current_dectree1.train

      current_dectree2 = dec_tree_configurations[1]
      current_dectree2.train

      current_dectree3 = dec_tree_configurations[2]
      current_dectree3.train

      current_dectree4 = dec_tree_configurations[3]
      current_dectree4.train

      current_dectree5 = dec_tree_configurations[5]
      current_dectree5.train

      test1 = [sanity_classification[0],        "Medium Sanity"]
      test2 = [hp_classification[0],                "Medium HP"]
      test3 = [atk_classification[0],     "Medium Attack Power"]
      test4 = [heal_classification[0],    "Medium Healing Rate"]
      test5 = [lunar_classification[0],        "Waxing Gibbous"]
  
      @decision1 = current_dectree1.predict(test1)
      @decision2 = current_dectree2.predict(test2)
      @decision3 = current_dectree3.predict(test3)
  
      puts "Enemy Status"
      puts "Enemy Sanity: #{@decision1} Enemy HP: #{@decision2} Enemy ATK: #{@decision3} Enemy Heal: #{@decision4} Lunar Phase: Enemy #{@decision5}"
      
      #ouvert("enemy_sanity/sanity_metric.txt",                                                   "Enemy Sanity: #{@decision1}",
      #       "enemy_standard/standard_metric.txt", "Enemy HP: #{@decision2} Enemy ATK: #{@decision3} Enemy Heal #{@decision4}",
      #       "lunar_phrase/current_phrase.txt",                                                  "Lunar Phrase: #{@decision5}")
    end

    ###################################################################################
    #                                 Is Anomalou?                                    #
    ###################################################################################
    def self.is_entity_anomalous?(a)
      if    a ==   :mundane; print "This entity is mundane. "
      elsif a == :uncertain; print "It is uncertain the nature of this entity. "
      elsif a == :anomalous; print "This entity is possibly anomalous in nature. "
      else
        print "It is uncertain the nature of this entity. "
      end
    end

    def self.study_artefacts?(d, e, f)
      a = :object,  d
      b = :subject, e
      c = :verb,    f
  
      g = :mundane, :uncertain, :anomalous
  
      aspects = [
        [[a[0], a[0], a[0]], [a[0], a[0], b[0]], [a[0], a[0], c[0]]],
        [[b[0], b[0], a[0]], [b[0], b[0], b[0]], [b[0], b[0], c[0]]],
        [[c[0], c[0], a[0]], [c[0], c[0], b[0]], [c[0], c[0], c[0]]],
      ], [
        [[a[1], a[1], a[1]], [a[1], a[1], b[1]], [a[1], a[1], c[1]]],
        [[b[1], b[1], a[1]], [b[1], b[1], b[1]], [b[1], b[1], c[1]]],
        [[c[1], c[1], a[1]], [c[1], c[1], b[1]], [c[1], c[1], c[1]]],
      ], [
        [[g[0], g[0], g[0]],
         [g[0], g[0], g[1]],
         [g[0], g[0], g[2]]],

        [[g[1], g[1], g[0]],
         [g[1], g[1], g[1]],
         [g[1], g[1], g[2]]],

        [[g[2], g[2], g[0]],
         [g[2], g[2], g[1]],
         [g[2], g[2], g[2]]],
      ]
  
      symbols      = aspects[0]
      description  = aspects[1]
      nature       = aspects[2]
  
      row_options = [0, 1, 2]
      col_options = [0, 1, 2]
      arr_options = [0, 1, 2]
  
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      current_symbol      = symbols[cur_row][cur_col][cur_arr] #.strip
      current_description = description[cur_row][cur_col][cur_arr] #.strip
      current_nature      = nature[cur_row][cur_col][cur_arr] #.strip

      $current_nature = current_nature
  
      "#{current_symbol}, #{current_description}"
    end

    # Elevators for retrieving traveling up a location and back down in one motion.
    def self.deux_chemix_ascenseur(a, b, c)
      "an elevator that takes #{a}, from #{b} to #{c} and back to #{b}."
    end

    ## A two way "elevator" that trades files rather than gets rid of them.
    #def deux_chemix_cinepark(a, b, c, d, e, f)
    #  new_file1 = a
    #  new_file2 = b
    #  
    #  old_directory1 = c
    #  old_directory2 = d
    #  
    #  new_directory1 = e
    #  new_directory2 = f
    #  
    #  wabisab(a, c, d)
    #  wabisab(b, e, f)
    #end

    def self.what_neighborhood?(a)
      a
    end

    def self.is_house_deceptive?(a, b)
      "That house of #{a}, is really a construct of #{b}."
    end

    def self.show_deception(a, b, c)
      require "NeoPathfinding"

      deceptive_houses = [
        [[a, a, a],
         [a, a, b],
         [a, a, c]],

        [[b, b, a],
         [b, b, b],
         [b, b, c]],
   
        [[c, c, a],
         [c, c, b],
         [c, c, c]],
      ]

      #probability_of_endpoint = 0.33 * 0.33 * 0.33

      row_options = [0, 1, 2]
      col_options = [0, 1, 2]
      arr_options = [0, 1, 2]
  
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      d = deceptive_houses[cur_row][cur_col][cur_arr]

     row_options = [0, 1, 2]
     col_options = [0, 1, 2]
     arr_options = [0, 1, 2]
  
     cur_row = row_options.sample
     cur_col = col_options.sample
     cur_arr = arr_options.sample
  
      e = deceptive_houses[cur_row][cur_col][cur_arr]
  
      row_options = [0, 1, 2]
      col_options = [0, 1, 2]
      arr_options = [0, 1, 2]
  
      cur_row = row_options.sample
      cur_col = col_options.sample
      cur_arr = arr_options.sample
  
      f = deceptive_houses[cur_row][cur_col][cur_arr]

      2.times do
        get_statistics(:first_deception,  d,
                       :second_deception, e,
                       :third_deception,  f)
                   
                       dynamic_reward_allocation
      end
    end

    def self.possible_deceptions
      require "NeoPathfinding"

      puts "Posible Deceptive Houses"
      show_deception(is_house_deceptive?(what_neighborhood?("San Antonio"),     "wood"),
                     is_house_deceptive?(what_neighborhood?("Las Angeles"), "concrete"),
                     is_house_deceptive?(what_neighborhood?("San Diego"),     "baselt"))
  
      puts "Two Way Escelators"
      a = "That house has: #{deux_chemix_ascenseur('wooden logs', 'entrance', 'drop off')}"
      b = "That house has: #{deux_chemix_ascenseur('cement',      'entrance', 'drop off')}"
      c = "That house has: #{deux_chemix_ascenseur('bedrock',     'entrance', 'drop off')}"

      2.times do
        get_statistics(:first_house,  a,
                       :second_house, b,
                       :third_house,  c)
                   
                       dynamic_reward_allocation
      end
    end

    # Part of dream studios
    def self.etudie_de_yume(a, b, c, d, e, f)
      a_list = [ a.to_sym, b, 0.33 ]
      b_list = [ c.to_sym, d, 0.33 ]
      c_list = [ e.to_sym, f, 0.33 ]
  
      a_analyses = is_house_deceptive?(a_list[0], deux_chemix_ascenseur("packages", "elevator entrance", "elevator cul de sac")), a_list[1]
      b_analyses = is_house_deceptive?(b_list[0], deux_chemix_ascenseur("packages", "elevator entrance", "elevator cul de sac")), b_list[1]
      c_analyses = is_house_deceptive?(c_list[0], deux_chemix_ascenseur("packages", "elevator entrance", "elevator cul de sac")), c_list[1]

      analyses_sessions = [
        [[a_analyses, a_analyses, a_analyses],
         [a_analyses, a_analyses, b_analyses],
         [a_analyses, a_analyses, c_analyses]],

        [[b_analyses, b_analyses, a_analyses],
         [b_analyses, b_analyses, b_analyses],
         [b_analyses, b_analyses, c_analyses]],

        [[c_analyses, c_analyses, a_analyses],
         [c_analyses, c_analyses, b_analyses],
         [c_analyses, c_analyses, c_analyses]],
      ]

      row_options = [0, 1, 2]
      col_options = [0, 1, 2]
      arr_options = [0, 1, 2]
  
      2.times do
        get_statistics(a_list[0], "[ #{a_list[1]}, #{a_list[2]} ]",
                       b_list[0], "[ #{b_list[1]}, #{b_list[2]} ]",
                       c_list[0], "[ #{c_list[1]}, #{c_list[2]} ]",)
   
                       dynamic_reward_allocation
      end
    end
    
    ###################################################################################
    #                          Find Predecessor Technology                            #
    ###################################################################################
    def self.find_predessesor(a, b)
      ancestor_group_one = File.readlines("data/predessesors/group_one.txt")
      ancestor_group_two = File.readlines("data/predessesors/group_two.txt")
      ancestor_group_tre = File.readlines("data/predessesors/group_tre.txt")
  
      size_limit = ancestor_group_one.size.to_i, ancestor_group_two.size.to_i, ancestor_group_tre.size.to_i
  
      group_one_limit = size_limit[0]
      group_two_limit = size_limit[1]
      group_two_limit = size_limit[2]

      index = 0
  
      group_one_limit.times do
        current_ancestors = ancestor_group_one[index].strip.to_s
    
        if current_ancestors == a
          $factoid_one = "#{current_ancestors} is the current generation of #{b} as its predessesor, therefore: #{a}"
    
          puts "#{current_ancestors} is the current generation of #{b} as its predessesor, therefore: #{a}"
        else
          puts "#{current_ancestors} is not the current generation of #{b} as its predessesor, therefore: #{a}"
        end
    
        index = index + 1
      end
  
      index = 0
  
      group_two_limit.times do
        current_ancestors = ancestor_group_two[index].strip.to_s

        if current_ancestors == a
          $factoid_two = "#{current_ancestors} is the current generation of #{b} as its predessesor, therefore: #{a}"
    
          puts "#{current_ancestors} is the current generation of #{b} as its predessesor, therefore: #{a}"
        else
          puts "#{current_ancestors} is not the current generation of #{b} as its predessesor, therefore: #{a}"
        end
    
        index = index + 1
      end

      index = 0
  
      group_two_limit.times do
        current_ancestors = ancestor_group_two[index].strip.to_s

        if current_ancestors == a
          $factoid_tre = "#{current_ancestors} is the current generation of #{b} as its predessesor, therefore: #{a}"
    
          puts "#{current_ancestors} is the current generation of #{b} as its predessesor, therefore: #{a}"

        else
          puts "#{current_ancestors} is not the current generation of #{b} as its predessesor, therefore: #{a}"
        end
    
        index = index + 1
      end
    end

    def self.analyze_predessecors
      factoid_one = $factoid_one # find_predessesor("Guillotine", "Halifax Gibbet")
      factoid_two = $factoid_two # find_predessesor("Guillotine", "Halifax Gibbet")
      factoid_tre = $factoid_tre # find_predessesor("Guillotine", "Halifax Gibbet")

      2.times do
        get_statistics(:trivia_one, factoid_one,
                       :trivia_two, factoid_two,
                       :trivia_tre, factoid_tre)
  
                       dynamic_reward_allocation
      end
    end

    ###################################################################################
    #                                Sort Memories                                    #
    ###################################################################################
    def self.rayonnage_de_papier(a, b, c)
      "You moved #{a} from shelf #{b} to shelf #{c}."
    end

    def self.correct_recollection(a, b, c)
      2.times do
        get_statistics(:remembered_a,     a,
                       :misremembered_b,  b,
                       :representation_c, c)
   
        dynamic_reward_allocation
      end

      print "You remembered #{a} was in #{c}, but instead #{b} is present in #{c}."
      puts " Consider checking with other documents or photos to verify."

      #thresholding($current_probability, 12, 12)
    end

    def self.correct_recollection2(a, b, c)
      2.times do
        get_statistics(:remembered_b,     a,
                       :misremembered_a,  b,
                       :representation_c, c)

        dynamic_reward_allocation
      end

      print "You remembered #{b} was in #{c}, but instead #{a} is present in #{c}."
      puts " Consider checking with other documents or photos to verify."

      #thresholding($current_probability, 12, 12)
    end

    def self.specify_memories
      puts "SPECIFY MEMORY"

      print "What specific inventory? << "; $inventory    = gets.chomp
      print       "What player shelf? << "; $player_shelf = gets.chomp
      print        "What enemy shelf? << "; $enemy_shelf  = gets.chomp
    end

    def self.sort_memories
      specify_memories

      puts "Memmory Recollections"
      puts rayonnage_de_papier($inventory, $player_shelf,  $enemy_shelf)
      puts rayonnage_de_papier($inventory, $enemy_shelf,   $player_shelf)
      puts rayonnage_de_papier($inventory, "unspecified",  "unspecified")
    end
  end
end

module Game
  class TownMechanics
  end

  class BattleMechanics
    ###################################################################################
    #                            Dynamic State Machine                                #
    ###################################################################################
    def self.gameloop
      loop do
        compared_player_hp = cette_int($player_hp <= 2) do
          monitor_acid_dragons
          monitor_sea_gargoyals
          monitor_acid_serpents
          monitor_traitorous_nuns
      
          puts "Player used a potion automatically to maintain their baseline."
 
          if $player_hp < 1
            system("clear")
      
            puts "GAME OVER"
      
            abort
          else
            contrast_player
          end
    
          if $enemy_hp < 1
            system("clear")
    
            puts "YOU WON"
      
            abort
          else
            contrast_enemy
          end
    
          GetStatistics::SubliminalStats.enemy_hp_tracker

          puts "\n[ PLAYER ] HP: #{$player_hp} ATK: #{$player_atk} DEF: #{$player_def} POTIONS: #{$potions}"
          puts "[ #{$current_monster_name.upcase} ] HP: #{$enemy_hp} ATK: #{$enemy_atk} DEF: #{$enemy_def}"
    
          GetStatistics::SubliminalStats.enemy_choice_tracker

          @cchoice = $cchoice
    
          print "#{$player_name} << "; @choice = gets.chomp
    
          puts "#{$current_monster_name}: #{@cchoice}"

          if actions[@cchoice] == @choice
            $player_hp = $player_hp + 1
    
            puts "Player Action: #{@choice}"
  
            # Check the player's choice string, not the actions hash
            if    @choice == "Lure"; lure
            elsif @choice == "Stun"; stun
            elsif @choice == "Trap"; trap
            else
              puts "This action is not valid..."
            end
          elsif @choice == @cchoice
            puts "Stalemate"
  
            $player_hp = $player_hp - 1
            $enemy_hp  = $enemy_hp - 1
          elsif actions[@choice] == @cchoice
            $player_hp = $player_hp - 1
    
            #puts @choice
            #puts @cchoice
          elsif @choice ==    "Sort Memories"; sort_memories
          elsif @choice == "Check Deceptions"; possible_deceptions
          elsif @choice ==       "Use Potion"; healing_formula
          elsif @choice ==             "Scan"; scan
          elsif @choice ==    "Analyze Coral"; CoralPool::OvertPolyps.vent_de_corail
          else
            puts "This action was not understood..."
          end  
        end

        compared_player_hp = maisette_int(compared_player_hp, $player_hp >= 8) do
          monitor_acid_dragons
          monitor_sea_gargoyals
          monitor_acid_serpents
          monitor_traitorous_nuns
    
          puts "The player is currently in excellent condition."
  
          if $player_hp < 1
            system("clear")
      
            puts "GAME OVER"
      
            abort
          else
            contrast_player
          end
    
          if $enemy_hp < 1
            system("clear")
    
            puts "YOU WON"
       
            abort
          else
            contrast_enemy
          end

          GetStatistics::SubliminalStats.enemy_hp_tracker

          puts "\n[ PLAYER ] HP: #{$player_hp} ATK: #{$player_atk} DEF: #{$player_def} POTIONS: #{$potions}"
          puts "[ #{$current_monster_name.upcase} ] HP: #{$enemy_hp} ATK: #{$enemy_atk} DEF: #{$enemy_def}"
    
          GetStatistics::SubliminalStats.enemy_choice_tracker

          @cchoice = $cchoice
      
          print "#{$player_name} << "; @choice = gets.chomp
  
          puts "#{$current_monster_name}: #{@cchoice}"

          if actions[@cchoice] == @choice
            $player_hp = $player_hp + 1
    
            puts "Player Action: #{@choice}"
  
            # Check the player's choice string, not the actions hash
            if    @choice == "Lure"; lure
            elsif @choice == "Stun"; stun
            elsif @choice == "Trap"; trap
            else
              puts "This action is not valid..."
            end
          elsif @choice == @cchoice
            puts "Stalemate"
  
            $player_hp = $player_hp - 1
            $enemy_hp  = $enemy_hp - 1
          elsif actions[@choice] == @cchoice
            $player_hp = $player_hp - 1
    
            #puts @choice
            #puts @cchoice
          elsif @choice ==    "Sort Memories"; sort_memories
          elsif @choice == "Check Deceptions"; possible_deceptions
          elsif @choice ==       "Use Potion"; healing_formula
          elsif @choice ==             "Scan"; scan
          elsif @choice ==    "Analyze Coral"; CoralPool::OvertPolyps.vent_de_corail
          else
            puts "This action was not understood..."
          end
        end

        compared_player_hp = sinon_int(compared_player_hp) do
          monitor_acid_dragons
          monitor_sea_gargoyals
          monitor_acid_serpents
          monitor_traitorous_nuns
    
          puts "Be mindful of monitoring your life points."

          if $player_hp < 1
            system("clear")
      
            puts "GAME OVER"
      
            abort
          else
            contrast_player
          end
    
          if $enemy_hp < 1
            system("clear")
    
            puts "YOU WON"

            abort
          else
            contrast_enemy
          end
    
          GetStatistics::SubliminalStats.enemy_hp_tracker

          puts "\n[ PLAYER ] HP: #{$player_hp} ATK: #{$player_atk} DEF: #{$player_def} POTIONS: #{$potions}"
          puts "[ #{$current_monster_name.upcase} ] HP: #{$enemy_hp} ATK: #{$enemy_atk} DEF: #{$enemy_def}"
    
          GetStatistics::SubliminalStats.enemy_choice_tracker

          @cchoice = $cchoice
    
          print "#{$player_name} << "; @choice = gets.chomp
          puts "#{$current_monster_name}: #{@cchoice}"

          if actions[@cchoice] == @choice
            $player_hp = $player_hp + 1
    
            puts "Player Action: #{@choice}"
  
            # Check the player's choice string, not the actions hash
            if    @choice == "Lure"; lure
            elsif @choice == "Stun"; stun
            elsif @choice == "Trap"; trap
            else
              puts "This action is not valid..."
            end
          elsif @choice == @cchoice
            puts "Stalemate"
  
            $player_hp = $player_hp - 1
            $enemy_hp  = $enemy_hp - 1
          elsif actions[@choice] == @cchoice
            $player_hp = $player_hp - 1
    
            #puts @choice
            #puts @cchoice
          elsif @choice ==    "Sort Memories"; sort_memories
          elsif @choice == "Check Deceptions"; possible_deceptions
          elsif @choice ==       "Use Potion"; healing_formula
          elsif @choice ==             "Scan"; scan
          elsif @choice ==    "Analyze Coral"; CoralPool::OvertPolyps.vent_de_corail
          else
            puts "This action was not understood..."
          end
        end
      end
    end
  end
end
