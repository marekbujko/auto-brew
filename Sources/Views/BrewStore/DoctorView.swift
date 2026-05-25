import SwiftUI

/// BrewStore section that renders the result of `brew doctor` as a
/// grouped list of findings. Designed as a passive surface — runs
/// the doctor on appear and on demand, never as a side effect of
/// another action, so the user always knows when `brew doctor` is
/// being invoked.
struct DoctorView: View {
    @State private var manager = BrewManager.shared
    @State private var isRunning = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            header
            Divider()
            content
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .task { await runIfStale() }
    }

    private var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text(String(localized: "Brew Doctor"))
                    .font(.title2.bold())
                Text(String(localized: "Health-check warnings reported by `brew doctor`. Most are advisory — fix them when you have a quiet moment, before they trip the next upgrade."))
                    .font(.callout)
                    .foregroundStyle(.secondary)
                if let report = manager.doctorReport {
                    Text(String(localized: "Checked \(report.ranAt.formatted(.relative(presentation: .named)))"))
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                }
            }
            Spacer()
            Button {
                Task { await run() }
            } label: {
                if isRunning {
                    ProgressView().controlSize(.small)
                } else {
                    Label(String(localized: "Run brew doctor"), systemImage: "stethoscope")
                }
            }
            .disabled(isRunning)
            .adaptiveProminentButtonStyle()
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }

    @ViewBuilder
    private var content: some View {
        if isRunning && manager.doctorReport == nil {
            ContentUnavailableView {
                ProgressView()
            } description: {
                Text(String(localized: "Asking brew how it feels…"))
            }
        } else if let report = manager.doctorReport {
            if report.isHealthy {
                ContentUnavailableView(
                    String(localized: "Brew is healthy"),
                    systemImage: "checkmark.seal.fill",
                    description: Text(String(localized: "`brew doctor` reported no warnings."))
                )
            } else {
                summary(report)
                List {
                    if report.errorCount > 0 {
                        Section(String(localized: "Errors")) {
                            ForEach(report.findings.filter { $0.severity == .error }) { finding in
                                findingRow(finding)
                            }
                        }
                    }
                    if report.warningCount > 0 {
                        Section(String(localized: "Warnings")) {
                            ForEach(report.findings.filter { $0.severity == .warning }) { finding in
                                findingRow(finding)
                            }
                        }
                    }
                }
                .listStyle(.inset)
            }
        } else {
            ContentUnavailableView(
                String(localized: "Doctor not run yet"),
                systemImage: "stethoscope",
                description: Text(String(localized: "Press Run brew doctor to ask brew for a health report."))
            )
        }
    }

    @ViewBuilder
    private func summary(_ report: DoctorReport) -> some View {
        HStack(spacing: 16) {
            stat(label: String(localized: "Errors"),
                 count: report.errorCount,
                 color: .red,
                 icon: "xmark.octagon.fill")
            stat(label: String(localized: "Warnings"),
                 count: report.warningCount,
                 color: .orange,
                 icon: "exclamationmark.triangle.fill")
        }
        .padding(.horizontal, 16)
    }

    @ViewBuilder
    private func stat(label: String, count: Int, color: Color, icon: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon).foregroundStyle(color)
            VStack(alignment: .leading, spacing: 1) {
                Text("\(count)")
                    .font(.title3.bold().monospacedDigit())
                Text(label)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }

    @ViewBuilder
    private func findingRow(_ finding: DoctorReport.Finding) -> some View {
        DisclosureGroup {
            Text(finding.body.isEmpty ? String(localized: "(no additional detail)") : finding.body)
                .font(.callout.monospaced())
                .textSelection(.enabled)
                .padding(.top, 4)
        } label: {
            HStack(spacing: 6) {
                Image(systemName: finding.severity == .error ? "xmark.octagon.fill" : "exclamationmark.triangle.fill")
                    .foregroundStyle(finding.severity == .error ? .red : .orange)
                Text(finding.title)
                    .font(.callout.weight(.medium))
                    .lineLimit(2)
            }
        }
    }

    // MARK: - Actions

    private func runIfStale() async {
        if manager.doctorReport == nil {
            await run()
        }
    }

    private func run() async {
        guard !isRunning else { return }
        isRunning = true
        defer { isRunning = false }
        await manager.runDoctor()
    }
}
