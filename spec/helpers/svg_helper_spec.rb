require "rails_helper"

RSpec.describe SvgHelper, type: :helper do
  describe "#render_svg" do
    let(:svg_path) { "icons/icon.svg" }
    let(:svg_asset) { "<svg>...</svg>" }

    context "when the asset exists" do
      before do
        allow(helper).to receive(:find_asset).with(svg_path).and_return(svg_asset)
      end

      it "returns the SVG asset" do
        expect(helper.render_svg(svg_path)).to eq(svg_asset)
      end

      context "when a tag is provided" do
        it "returns the SVG asset wrapped in the tag" do
          expect(helper.render_svg(svg_path, tag: :div)).to eq("<div>#{svg_asset}</div>")
        end

        context "when classes are provided" do
          it "returns the SVG asset wrapped in the tag with the classes" do
            expect(helper.render_svg(svg_path, tag: :div, classes: "icon")).to eq("<div class=\"icon\">#{svg_asset}</div>")
          end
        end
      end
    end

    context "when the asset does not exist" do
      before do
        allow(helper).to receive(:find_asset).with(svg_path).and_return(nil)
      end

      it "returns nil" do
        expect(helper.render_svg(svg_path)).to be_nil
      end
    end
  end

  describe "#find_asset" do
    let(:svg_path) { "icons/icon.svg" }
    let(:asset_path) { "icons/icon-1234567890.svg" }
    let(:asset_source) { "<svg>...</svg>" }

    context "when the path is nil" do
      it "returns nil" do
        expect(helper.find_asset(nil)).to be_nil
      end
    end

    context "when the environment is production or staging" do
      before do
        allow(Rails).to receive_message_chain(:env, :production?).and_return(true)
        allow(Rails).to receive_message_chain(:env, :staging?).and_return(false)
        allow(Rails.application.assets_manifest.assets).to receive(:[]).with(svg_path).and_return(asset_path)
        allow(File).to receive(:read).with(Rails.root.join("public", "assets", asset_path)).and_return(asset_source)
      end

      it "reads the asset from the public directory" do
        expect(helper.find_asset(svg_path)).to eq(asset_source)
      end
    end

    context "when the environment is not production or staging" do
      before do
        allow(Rails).to receive_message_chain(:env, :production?).and_return(false)
        allow(Rails).to receive_message_chain(:env, :staging?).and_return(false)
        allow(Rails.application.assets).to receive(:[]).with(svg_path).and_return(double(source: asset_source))
      end

      it "returns the asset source" do
        expect(helper.find_asset(svg_path)).to eq(asset_source)
      end
    end
  end
end
