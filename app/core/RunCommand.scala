package core

import java.io.{BufferedReader, IOException, InputStreamReader}

object RunCommand {
  def runTest(): List[String] = {
    val processBuilder = new ProcessBuilder()
    processBuilder.command("cmd.exe", "/c", "ping -n 3 google.com")
    var lines: List[String] = Nil
    try {
      val process = processBuilder.start()
      val reader: BufferedReader = new BufferedReader(new InputStreamReader(process.getInputStream))
      var line: String = ""
      while ({line = reader.readLine(); line != null}) {
        lines = lines.concat(List(line))
      }

      val exitCode = process.waitFor()
      println(lines)
      println("\nExited with error code : " + exitCode)
      lines
    } catch {
     case e: IOException => e.printStackTrace()
       lines
     case e: InterruptedException => e.printStackTrace()
        lines
    }

  }

}
