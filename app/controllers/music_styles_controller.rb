class MusicStylesController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:add_style] 

    def generate
        styles = MusicStyle.order("RANDOM()").limit(2)
        
        if styles.size < 2
            render json: { error: "Not enough styles on database, add styles to do it" }, status: :unprocessable_entity
        else
            render json: { styles: styles.map(&:name) }
        end
    end

    def add_style
        # Recebe o JSON do corpo da requisição
        names = params[:names]
    
        # Verifica se o parâmetro é válido
        if names.is_a?(Array)
          # Cria os registros na tabela music_styles
          names.each do |name|
            MusicStyle.create(name: name)
          end
    
          # Retorna uma resposta de sucesso
          render json: { message: "Music styles created successfully" }, status: :created
        else
          # Retorna uma resposta de erro
          render json: { error: "Invalid input. Expected an array of strings." }, status: :unprocessable_entity
        end    
    end    
end
  