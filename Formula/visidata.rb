class Visidata < Formula
  include Language::Python::Virtualenv
  desc "Terminal utility for exploring and arranging tabular data"
  homepage "https://visidata.org/"
  url "https://files.pythonhosted.org/packages/4e/45/75bec1b89ec27b0e74f84da2f036a20f9ed7d15c4e53283efb12cb355ede/visidata-2.11.tar.gz"
  version "2.11"
  sha256 "c09ecb65025dc9d6513bfd5e5aff9c430ffc325cc183b81abf5f2df5a96b66b3"

  depends_on "python"

  on_linux do
    depends_on "libxml2"
    depends_on "libxslt"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/71/39/171f1c67cd00715f190ba0b100d606d440a28c93c7714febeca8b79af85e/six-1.16.0.tar.gz"
    sha256 "1e61c37477a1626458e36f7b1d82aa5c9b094fa4802892072e49de9c60c4c926"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/4c/c4/13b4776ea2d76c115c1d1b84579f3764ee6d57204f6be27119f13a61d0a9/python-dateutil-2.8.2.tar.gz"
    sha256 "0123cacc1627ae19ddf3c27a5de5bd67ee4586fbdd6440d9748f8abb483d3e86"
  end

  resource "et-xmlfile" do
    url "https://files.pythonhosted.org/packages/3d/5d/0413a31d184a20c763ad741cc7852a659bf15094c24840c5bdd1754765cd/et_xmlfile-1.1.0.tar.gz"
    sha256 "8eb9e2bc2f8c97e37a2dc85a09ecdcdec9d8a396530a6d5a33b30b9a92da0c5c"
  end

  resource "jdcal" do
    url "https://files.pythonhosted.org/packages/7b/b0/fa20fce23e9c3b55b640e629cb5edf32a85e6af3cf7af599940eb0c753fe/jdcal-1.4.1.tar.gz"
    sha256 "472872e096eb8df219c23f2689fc336668bdb43d194094b5cc1707e1640acfc8"
  end

  resource "openpyxl" do
    url "https://files.pythonhosted.org/packages/2c/b8/ff77a718173fd73e49f883b4fda88f11af1fc51edb9252af3785b0cad987/openpyxl-3.0.10.tar.gz"
    sha256 "e47805627aebcf860edb4edf7987b1309c1b3632f3750538ed962bbcc3bd7449"
  end

  resource "xlrd" do
    url "https://files.pythonhosted.org/packages/a6/b3/19a2540d21dea5f908304375bd43f5ed7a4c28a370dc9122c565423e6b44/xlrd-2.0.1.tar.gz"
    sha256 "f72f148f54442c6b056bf931dbc34f986fd0c3b0b6b5a58d013c9aef274d0c88"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/8b/e1/43beb3d38dba6cb420cefa297822eac205a277ab43e5ba5d5c46faf96438/idna-3.4.tar.gz"
    sha256 "814f528e8dead7d329833b91c5faa87d60bf71824cd12a7530b5526063d02cb4"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/37/f7/2b1b0ec44fdc30a3d31dfebe52226be9ddc40cd6c0f34ffc8923ba423b69/certifi-2022.12.7.tar.gz"
    sha256 "35824b4c3a97115964b408844d64aa14db1cc518f6562e8d7261699d1350a9e3"
  end

  resource "chardet" do
    url "https://files.pythonhosted.org/packages/41/32/cdc91dcf83849c7385bf8e2a5693d87376536ed000807fa07f5eab33430d/chardet-5.1.0.tar.gz"
    sha256 "0d62712b956bc154f85fb0a266e2a3c5913c2967e00348701b32411d6def31e5"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/c5/52/fe421fb7364aa738b3506a2d99e4f3a56e079c0a798e9f4fa5e14c60922f/urllib3-1.26.14.tar.gz"
    sha256 "076907bf8fd355cde77728471316625a4d2f7e713c125f51953bb5b3eecf4f72"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/9d/ee/391076f5937f0a8cdf5e53b701ffc91753e87b07d66bae4a09aa671897bf/requests-2.28.2.tar.gz"
    sha256 "98b1b2782e3c6c4904938b84c0eb932721069dfdb9134313beff7c83c2df24bf"
  end

  resource "lxml" do
    url "https://files.pythonhosted.org/packages/06/5a/e11cad7b79f2cf3dd2ff8f81fa8ca667e7591d3d8451768589996b65dec1/lxml-4.9.2.tar.gz"
    sha256 "2455cfaeb7ac70338b3257f41e21f0724f4b5b0c0e7702da67ee6c3640835b67"
  end

  def install
    venv = virtualenv_create(libexec, "python3")
    venv.pip_install resources
    venv.pip_install_and_link buildpath
    man1.install "visidata/man/vd.1"
    man1.install "visidata/man/visidata.1"
  end

  test do
    (testpath/"test_visidata.sh").write <<~EOS
      #!/usr/bin/env bash
      curl -O https://raw.githubusercontent.com/saulpw/visidata/stable/tests/exp-digits.vd
      vd --play exp-digits.vd --batch --output results_test.tsv
    EOS
    chmod 0755, testpath/"test_visidata.sh"
    system "./test_visidata.sh"
    assert_predicate testpath/"results_test.tsv", :exist?
  end
end
