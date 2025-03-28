# ide-docker-x11dev-phpstorm
All necessary for running PhpStorm inside a docker container with X11 forwarded.

This is working under Ubuntu 25.03.

I recommand to any of your project that need PhpStorm IDE to add the current repo as Git submodule with following command:
```
git submodule add https://github.com/vanbe/ide-docker-x11dev-phpstorm.git ide/phpstorm
```
Then you need to add execution permissions and build docker images.
```
chmod +x ide/phpstorm/run.sh ide/phpstorm/build/build.sh
./ide/phpstorm/build/build.sh
```
You can now start your PhpStorm with all necessary just by running:
```
./ide/phpstorm/run.sh
```
