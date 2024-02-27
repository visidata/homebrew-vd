class Visidata < Formula
  include Language::Python::Virtualenv
  desc "Terminal utility for exploring and arranging tabular data"
  homepage "https://visidata.org/"
  url "https://files.pythonhosted.org/packages/8c/75/3e2f5c7c8b129d34a28d02741e13ae6e1bc41c3fcdb0a3e45b54eb2defe0/visidata-3.0.2.tar.gz"
  sha256 "38c38df08c1b48dde5f9ae1bdb02cb19f70acf0461d0e85cb14f9c002a77c05a"
  revision 1

  depends_on "python3"

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

  resource "chardet" do
    url "https://files.pythonhosted.org/packages/41/32/cdc91dcf83849c7385bf8e2a5693d87376536ed000807fa07f5eab33430d/chardet-5.1.0.tar.gz"
    sha256 "0d62712b956bc154f85fb0a266e2a3c5913c2967e00348701b32411d6def31e5"
  end

  resource "lxml" do
    url "https://files.pythonhosted.org/packages/84/14/c2070b5e37c650198de8328467dd3d1681e80986f81ba0fea04fc4ec9883/lxml-4.9.4.tar.gz"
    sha256 "b1541e50b78e15fa06a2670157a1962ef06591d4c998b998047fff5e3236880e"
  end

  resource "zipp" do
    url "https://files.pythonhosted.org/packages/58/03/dd5ccf4e06dec9537ecba8fcc67bbd4ea48a2791773e469e73f94c3ba9a6/zipp-3.17.0.tar.gz"
    sha256 "84e64a1c28cf7e91ed2078bb8cc8c259cb19b76942096c8d7b84947690cabaf0"
  end

  resource "importlib-resources" do
    url "https://files.pythonhosted.org/packages/4e/a2/3cab1de83f95dd15297c15bdc04d50902391d707247cada1f021bbfe2149/importlib_resources-5.12.0.tar.gz"
    sha256 "4be82589bf5c1d7999aedf2a45159d10cb3ca4f19b2271f8792bc8e6da7b22f6"
  end

  resource "importlib-metadata" do
    url "https://files.pythonhosted.org/packages/90/b4/206081fca69171b4dc1939e77b378a7b87021b0f43ce07439d49d8ac5c84/importlib_metadata-7.0.1.tar.gz"
    sha256 "f238736bb06590ae52ac1fab06a3a9ef1d8dce2b7a35b5ab329371d6c8f5d2cc"
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
