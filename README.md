# Travis CI ( Continuous Integration ) Learning #

## Travis CI 的优缺点 ##
### 优点 ###

* 小清新: 配置简单

```yaml
language: cpp
env:
  matrix:
  - PLATFORM=linux DEBUG=1

script:
  - $CXX helloworld.cpp -o helloworld
  - ./helloworld

before_install:

compiler:
  - clang
  - gcc
```

* 和Github非常暧昧:)
* 提供免费的服务器
* 网络速度非常快，平均10m/s以上
* 每次的构建都是干净的，排除历史构建的干扰
	+ **其他ci(Jenkins)**都是在历史的基础上pull最新代码
    + 动态分配VM,使用完删除
* 支持的语言很多: C, C++, Clojure, Erlang, Go, Groovy, Haskell, Java, Javascript(with
Node.js), Objective-C, Perl, PHP, Python, Ruby, Scala
	+ 这些支持的语言是指默认在Host机器上安装好了`开发环境`，其实没有安装也是可以进行构建的，cocos2d-x
    的android环境就是人为配置的，需要下载对应的ndk, 其实直接把travis当成一个正常的ubuntu和osx机器使用
    也是没任何问题的。


### 缺点 ###

* Windows被鄙视，O(∩_∩)O哈哈~
* 虽然编译环境支持`OSX`和`Ubuntu`,但是一次构建不同任务无法分别使用不同的平台，`OSX`和`Ubuntu`二者选一
`Travis-CI`是根据language选择对应的host，除了`objective-c`是用`OSX`，其他都是用`Ubuntu`作为Host


## CI 环境变量 ##

* `CI=true`
* `TRAVIS=true`
* `DEBIAN_FRONTEND=noninteractive`
* `HAS_JOSH_K_SEAL_OF_APPROVAL=true`
* `USER=travis (do not depend on this value)`
* `HOME=/home/travis (do not depend on this value)`
* `LANG=en_US.UTF-8`
* `LC_ALL=en_US.UTF-8`
* `RAILS_ENV=test`
* `RACK_ENV=test`
* `MERB_ENV=test`
* `JRUBY_OPTS="--server -Dcext.enabled=false -Xcompile.invokedynamic=false"`

Additionally, Travis sets environment variables you can use in your build, e.g. to tag the build, or to run post-build deployments.

* `TRAVIS_BRANCH`: 当前构建分支名称
* `TRAVIS_BUILD_DIR`: 仓库在构建host机器上的绝对路径
* `TRAVIS_BUILD_ID`: Travis内部使用的当前构建的唯一ID
* `TRAVIS_BUILD_NUMBER`: 当前构建号 e.g. 2
* `TRAVIS_COMMIT`: 当前构建commit的SHA-1
* `TRAVIS_COMMIT_RANGE`: 当前构建的commit范围
* `TRAVIS_JOB_ID`: travis内部使用的当前任务ID
* `TRAVIS_JOB_NUMBER`: 当前任务编号 e.g. 2.1
* `TRAVIS_PULL_REQUEST`: 若是PullRequest触发的构建，则为Pull Request编号，否则为false
* `TRAVIS_SECURE_ENV_VARS`: 值为true或者false, 是否用到了加密变量
* `TRAVIS_REPO_SLUG`: 当前仓库，格式为owner_name/repo_name

语言相关的变量

* `TRAVIS_RUBY_VERSION`
* `TRAVIS_JDK_VERSION`
* `TRAVIS_NODE_VERSION`
* `TRAVIS_PHP_VERSION`
* `TRAVIS_PYTHON_VERSION`

## 使用apt安装软件依赖 ##

sudo apt-get install -qq


## 如何让github上面的项目支持travis-ci持续集成 ##
* 用github账户登陆 [Travis-CI](https://travis-ci.org), 授权travis-ci访问github仓库
* Accounts --> Repositories --> 开启需要支持travis-ci的仓库
* 编写.travis.yml文件，放置项目根目录

## C 工程的CI 环境 ##

```
Travis VMs are 64 bit and currently provide
gcc 4.6
clang 3.1
core GNU build toolchain (autotools, make), cmake, scons
```


## 如何编写.travis.yml ##

参考 [Configuring your Travis CI build with .travis.yml](http://about.travis-ci.org/docs/user/build-configuration/ )

* 构建生命周期
	+ 切换到当前语言的*运行时*(比如Ruby 1.9.3 or CPP)
    + clone 整个项目，包含更新子模块(无法在clone前执行用户script)
    + 执行**before_install**脚本(若存在)
    + 进入clone好的仓库目录，执行对应的安装命令（若无指定，命令依赖于当前语言）
    + 执行**before_script**脚本(若存在)
    + 执行并测试**script**命令（若无指定，则依赖当前语言），exit code为0表示成功，反之失败
    + 执行**after_success/after_failure**脚本(若存在)
    + 执行**after_script**脚本(若存在)

构建结果被放置在`TRAVIS_TEST_RESULT`变量中，可用在**after_script**脚本中

### YAML 语法 ###
```yaml
before_script:
  - before_command_1
  - before_command_2
  - sh -c "if [ '$DB' = 'pgsql' ]; then psql -c 'DROP DATABASE IF EXISTS doctrine_tests;' -U postgres; fi"
after_script:
  - after_command_1
  - after_command_2
```
### 可以用travis-lint检查对应的配置是否合法 ###
目前还比较简陋。检查功能不强


### 覆盖默认的脚本命令 ###

* cpp工程默认编译命令：`./configure && make && make test`，
可以使用`script`字段覆盖默认命令

* cpp工程默认导出两个环境变量：`CXX`和`CC`，他们的值由使用的编译器决定
```yaml
compiler:
  - clang
  - gcc
```

## 构建完成后发送通知 ##

`Travis CI` 能通过`email`,`IRC`, `Campfire`, `Flowdock`, `HipChat`
和`webhooks`来发送构建结果的通知

### email通知 ###

他默认发送email给

* 添加新commit的作者
* 这个仓库的所有者

可以完全关闭email通知

```yaml
notifications:
  email: false
```

也可以定制发送email地址和条件(Success or Faiure)

```yaml
notifications:
  email:
    recipients:
      - one@example.com
      - other@example.com
    on_success: [always|never|change] # default: change
    on_failure: [always|never|change] # default: always
```
`always`: 每次构建成功(或失败)的时候发送通知
`never` : 每次构建成功(或失败)都不发送通知
`change`: 当编译状态改变的时候发送通知，success -> failure 或者 failure -> success



## 加密重要数据 ##

### Cocos2d-x 中使用的加密 ###

* `Cocos2d-x` `travis-ci`含有三组加密数据，分别是GH_USER, GH_PASSWORD, GH_EMAIL
他们是`CocosRobot`的账户、密码和邮件
	* 用于`bindings-generator`生成的新jsbindings glue代码产生变化的时候*push*
    到 [auto-gen-jsb-repo](https://github.com/folecr/cocos2dx-autogen-bindings)
    * `CocosRobot`向`cocos2d-x`发送`jsbindings`自动绑定代码的`Pull Request`

### How to ? ###

```sh
gem install travis
travis encrypt github用户名/仓库名称 "GH_USER=xxx GH_PASSWORD=xxx"
```

Then you need to add them as ENV variable in .travis.yml:

```yaml
env:
  global:
    - secure: ".... encrypted string here ....."
```

And use them in your script:

```sh
export REPO="$(pwd | sed s,^/home/travis/builds/,,g)"
ssh -o StrictHostKeyChecking=no
if [ "$TRAVIS_BRANCH" == "travis" ]; then
    git branch -D gh-pages
    git checkout -B gh-pages
    git add -f dist/.
    git commit -m "Add built output"
    git push https://$(GH_USER):$(GH_PASSWORD)@github.com/${REPO} gh-pages
fi
```

题外话：如何通过命令行发送Pull Request
```sh
curl --user "${GH_USER}:${GH_PASSWORD}" --request POST --data "{ \"title\": \"$COMMITTAG : updating submodule reference to latest autogenerated bindings\", \"body\": \"\", \"head\": \"${GH_USER}:${COCOS_BRANCH}\", \"base\": \"${TRAVIS_BRANCH}\"}" https://api.github.com/repos/cocos2d/cocos2d-x/pulls 2> /dev/null > /dev/null
```


## 构建环境、matrix配置 ##
