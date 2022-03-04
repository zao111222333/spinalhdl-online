import mill._, scalalib._
import coursier.maven.MavenRepository
import $ivy.`com.lihaoyi::mill-contrib-bloop:$MILL_VERSION`

val spinalVersion = "1.6.4"

object mylib extends SbtModule {
  def scalaVersion = "2.12.14"
  override def millSourcePath = os.pwd
  def ivyDeps = Agg(
    ivy"com.github.spinalhdl::spinalhdl-core:$spinalVersion",
    ivy"com.github.spinalhdl::spinalhdl-lib:$spinalVersion"
  )
  def scalacPluginIvyDeps = Agg(ivy"com.github.spinalhdl::spinalhdl-idsl-plugin:$spinalVersion")
}