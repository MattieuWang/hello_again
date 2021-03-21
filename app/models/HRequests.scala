package models

import java.time.{ZoneOffset, ZonedDateTime}

import akka.http.scaladsl.model.RemoteAddress

case class HRequests(
  timeStamp: ZonedDateTime = ZonedDateTime.now(ZoneOffset.UTC).withNano(0),
  remoteAddress: Option[String] = None

)
