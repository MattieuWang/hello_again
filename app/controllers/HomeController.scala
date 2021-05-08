package controllers

import akka.actor.{ActorRef, ActorSystem, Props}
import akka.http.scaladsl.Http
import core.RunCommand
import javax.inject._
import models.HRequests
import play.api._
import play.api.libs.json.Json
import play.api.libs.streams.ActorFlow
import play.api.mvc._

@Singleton
class HomeController @Inject()(
  implicit system: ActorSystem,
  val controllerComponents: ControllerComponents) extends BaseController {

  def index() = Action { implicit request: Request[AnyContent] =>
    println(request.headers.toSimpleMap)
    Ok(views.html.index())
  }

  def connections() = Action { implicit request: Request[AnyContent] =>
    val lines = RunCommand.runTest()
    Ok(Json.toJson(lines))
  }

  def home() = Action { implicit request: Request[AnyContent] =>
    println(request.headers.toSimpleMap)
    Ok("This is a home page with nothing :)")
  }

}

