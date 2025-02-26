class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end



  def create
    m = Director.new
    m.name = params.fetch("the_name")
    m.dob = params.fetch("the_dob")
    m.bio = params.fetch("the_bio")
    m.image = params.fetch("the_image")
    m.save
  
    redirect_to("/directors")
  end

  def destroy
    the_id = params.fetch("an_id")

    matching_records = Director.where({:id => the_id})
    the_director = matching_records.at(0)
    the_director.destroy

    redirect_to("/directors")
  end


  def update
    a_id = params.fetch("the_id")
    matching_records = Director.where({:id => a_id})
    a = matching_records.at(0)

    a.name = params.fetch("the_name")
    a.dob = params.fetch("the_dob")
    a.bio = params.fetch("the_bio")
    a.image = params.fetch("the_image")
    a.save
    
    redirect_to("/directors/#{a.id}")
  end




end
