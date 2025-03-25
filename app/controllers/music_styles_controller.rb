class MusicStylesController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:add_style, :generate, :list_style, :delete_style, :delete_all_styles]

    def generate
        styles = MusicStyle.order("RANDOM()").limit(2)
        
        puts "\n\nAccept: #{request.headers['Accept']}"
        puts "\n\nFormat: #{request.format}"
        puts "\n\nstyles: #{styles.map(&:name)}"

        respond_to do |format|
            format.any do
                if styles.size < 2
                    render json: { error: "Not enough styles on database, add styles to do it" }, status: :unprocessable_entity
                else
                    render json: { styles: styles.map(&:name) }, status: :ok
                end
            end
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

    def list_style
        styles = MusicStyle.all

        if styles.any?
            render json: { styles: styles.map(&:name) }
        else
            render json: { message: "No styles found" }, status: :not_found
        end
    end

    def delete_style
        style = MusicStyle.find_by(name: params[:name])

        if style
            style.destroy
            render json: { message: "Music style deleted successfully" }, status: :ok
        else
            render json: { error: "Music style not found" }, status: :not_found
        end
    end

    def delete_all_styles
        MusicStyle.destroy_all
        render json: { message: "All music styles deleted successfully" }, status: :ok
    end
end
  