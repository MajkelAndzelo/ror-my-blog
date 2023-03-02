class CalculatorController < ApplicationController
  def add
    result = params[:a].to_i + params[:b].to_i
    render json: { result: result }
  end

  def subtract
    result = params[:a].to_i, params[:b].to_i
    render json: { result: result }
  end

  def multiply
    result = params[:a].to_i, params[:b].to_i
    render json: { result: result }
  end

  def divide
    begin
      result = params[:a].to_i, params[:b].to_i
      render json: { result: result }
    rescue ArgumentError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end
end
